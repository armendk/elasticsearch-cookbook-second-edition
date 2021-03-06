# [2013-11-22T15:32:30.957291]
curl -XHEAD 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 404
# response body: 
# [2013-11-22T15:32:30.958151]
curl -XPUT 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
# [2013-11-22T15:32:30.981811]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/_mapping?pretty=true' -d '{"test-type": {"properties": {"pos": {"type": "integer", "store": "yes"}, "uuid": {"index": "not_analyzed", "boost": 1.0, "store": "yes", "type": "string"}, "parsedtext": {"index": "analyzed", "term_vector": "with_positions_offsets", "boost": 1.0, "store": "yes", "type": "string"}, "name": {"index": "analyzed", "term_vector": "with_positions_offsets", "boost": 1.0, "store": "yes", "type": "string"}, "title": {"index": "analyzed", "term_vector": "with_positions_offsets", "boost": 1.0, "store": "yes", "type": "string"}}}}'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
# [2013-11-22T15:32:30.992882]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type2/_mapping?pretty=true' -d '{"test-type2": {"_parent": {"type": "test-type"}}}'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
# [2013-11-22T15:32:30.995636]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/1?pretty=true' -d '{"position": 1, "parsedtext": "Joe Testere nice guy", "name": "Joe Tester", "uuid": "11111"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type","_id":"1","_version":1}
# [2013-11-22T15:32:30.998216]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type2/1?parent=1&pretty=true' -d '{"name": "data1", "value": "value1"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type2","_id":"1","_version":1}
# [2013-11-22T15:32:31.000099]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/2?pretty=true' -d '{"position": 2, "parsedtext": "Bill Testere nice guy", "name": "Bill Baloney", "uuid": "22222"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type","_id":"2","_version":1}
# [2013-11-22T15:32:31.002422]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type2/2?parent=2&pretty=true' -d '{"name": "data2", "value": "value2"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type2","_id":"2","_version":1}
# [2013-11-22T15:32:31.003829]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/3?pretty=true' -d '{"position": 3, "parsedtext": "Bill is not\n                nice guy", "name": "Bill Clinton", "uuid": "33333"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type","_id":"3","_version":1}
# [2013-11-22T15:32:31.005919]
curl -XPOST 'http://127.0.0.1:9200/test-index/_refresh?pretty=true'
# response status: 200
# response body: {"ok":true,"_shards":{"total":10,"successful":5,"failed":0}}
# [2013-11-22T15:32:31.015451]
curl -XGET 'http://127.0.0.1:9200/_cluster/health?wait_for_status=green&timeout=0s&pretty=true'
# response status: 200
# response body: {"cluster_name":"elasticsearch","status":"yellow","timed_out":true,"number_of_nodes":1,"number_of_data_nodes":1,"active_primary_shards":12,"active_shards":12,"relocating_shards":0,"initializing_shards":0,"unassigned_shards":11}
# [2013-11-22T15:32:31.217301]
curl -XGET 'http://127.0.0.1:9200/test-index/test-type/_search?from=0&pretty=true&size=10' -d '{"query": {"custom_score": {"lang": "js", "query": {"match_all": {}}, "script": "parseFloat(_score*(5+doc.position.value))"}}}'
# response status: 400
# response body: {"error":"SearchPhaseExecutionException[Failed to execute phase [query], all shards failed; shardFailures {[0_XGViGhSvOT6mmHGpV3vQ][test-index][0]: SearchParseException[[test-index][0]: from[-1],size[-1]: Parse Failure [Failed to parse source [{\"query\": {\"custom_score\": {\"lang\": \"js\", \"query\": {\"match_all\": {}}, \"script\": \"parseFloat(_score*(5+doc.position.value))\"}}}]]]; nested: QueryParsingException[[test-index] [custom_score] the script could not be loaded]; nested: ElasticSearchIllegalArgumentException[script_lang not supported [js]]; }{[0_XGViGhSvOT6mmHGpV3vQ][test-index][2]: SearchParseException[[test-index][2]: from[-1],size[-1]: Parse Failure [Failed to parse source [{\"query\": {\"custom_score\": {\"lang\": \"js\", \"query\": {\"match_all\": {}}, \"script\": \"parseFloat(_score*(5+doc.position.value))\"}}}]]]; nested: QueryParsingException[[test-index] [custom_score] the script could not be loaded]; nested: ElasticSearchIllegalArgumentException[script_lang not supported [js]]; }{[0_XGViGhSvOT6mmHGpV3vQ][test-index][1]: SearchParseException[[test-index][1]: from[-1],size[-1]: Parse Failure [Failed to parse source [{\"query\": {\"custom_score\": {\"lang\": \"js\", \"query\": {\"match_all\": {}}, \"script\": \"parseFloat(_score*(5+doc.position.value))\"}}}]]]; nested: QueryParsingException[[test-index] [custom_score] the script could not be loaded]; nested: ElasticSearchIllegalArgumentException[script_lang not supported [js]]; }{[0_XGViGhSvOT6mmHGpV3vQ][test-index][4]: SearchParseException[[test-index][4]: from[-1],size[-1]: Parse Failure [Failed to parse source [{\"query\": {\"custom_score\": {\"lang\": \"js\", \"query\": {\"match_all\": {}}, \"script\": \"parseFloat(_score*(5+doc.position.value))\"}}}]]]; nested: QueryParsingException[[test-index] [custom_score] the script could not be loaded]; nested: ElasticSearchIllegalArgumentException[script_lang not supported [js]]; }{[0_XGViGhSvOT6mmHGpV3vQ][test-index][3]: SearchParseException[[test-index][3]: from[-1],size[-1]: Parse Failure [Failed to parse source [{\"query\": {\"custom_score\": {\"lang\": \"js\", \"query\": {\"match_all\": {}}, \"script\": \"parseFloat(_score*(5+doc.position.value))\"}}}]]]; nested: QueryParsingException[[test-index] [custom_score] the script could not be loaded]; nested: ElasticSearchIllegalArgumentException[script_lang not supported [js]]; }]","status":400}
# [2013-11-22T15:32:31.223385]
curl -XHEAD 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 200
# response body: 
# [2013-11-22T15:32:31.224152]
curl -XDELETE 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
