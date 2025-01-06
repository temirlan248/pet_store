openapi-generator generate -i ../assets/swagger/swagger.json -g dart-dio -o ../api_client
cd api_client
dart run build_runner build