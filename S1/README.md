## Client Test w/LeoFS Ansible
CI Pipeline used by LeoFS Team to test compatibility with various S3 SDKs

## SDKs in Test
1. [aws-sdk-java](https://aws.amazon.com/sdk-for-java)
2. [aws-sdk-php](https://aws.amazon.com/sdk-for-php/)
3. [aws-sdk-ruby](https://aws.amazon.com/sdk-for-ruby)
4. [boto (Python)](https://github.com/boto/boto)
5. [erlcloud (Erlang)](https://github.com/erlcloud/erlcloud)
6. [jclouds (Java)](https://jclouds.apache.org/)

## Notes
As LeoFS 1.2 only support signature V2, SDKs are only tested with V2. V4 support is planned for LeoFS 1.3
