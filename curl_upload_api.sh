#!/bin/bash

# Example:

# 0. export API_KEY=api_key_string

# 1. Upload VCL for domain cachoid.com
# sh curl_upload_api.s $API_KEY cachoid.com

set -x;

if [ ${#} -lt '3' ];
then
	echo "$0 <file.vcl> <token> <fqdn>";
else
	curl -F file=@$1 -XPOST -vvv -H "Accept: application/vnd.cachoid.v1+json" -H "Authorization: Bearer $2" http://api.cachoid.com/vcl/upload/$3
fi
