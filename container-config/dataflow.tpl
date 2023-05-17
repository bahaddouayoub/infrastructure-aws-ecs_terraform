[
  {
    "name": "LANG",
    "value": "en_US.utf8"
  },
  {
    "name": "LC_ALL",
    "value": "en_US.utf8"
  },
  {
    "name": "JDK_JAVA_OPTIONS",
    "value": "-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"
  },
  {
    "name": "SPRINGDOC_APIDOCS_ENABLED",
    "value": "true"
  },
  {
    "name": "SPRINGDOC_SWAGGERUI_ENABLED",
    "value": "true"
  },
  {
    "name": "SPRING_CLOUD_DATAFLOW_APPLICATIONPROPERTIES_STREAM_SPRING_KAFKA_STREAMS_PROPERTIES_METRICS_RECORDING_LEVEL",
    "value": "DEBUG"
  },
  {
    "name": "SPRING_CLOUD_DATAFLOW_APPLICATIONPROPERTIES_TASK_SPRING_CLOUD_TASK_CLOSECONTEXTENABLED",
    "value": "true"
  },
  {
    "name": "SPRING_CLOUD_DATAFLOW_APPLICATIONPROPERTIES_STREAM_SPRING_CLOUD_STREAM_KAFKA_STREAMS_BINDER_BROKERS",
    "value": "${bootstrap_brokers}"
  },
  {
      "name": "SPRING_CLOUD_DATAFLOW_APPLICATIONPROPERTIES_STREAM_SPRING_CLOUD_STREAM_KAFKA_BINDER_BROKERS",
      "value": "${bootstrap_brokers}"
  },
  {
    "name": "SPRING_CLOUD_SKIPPER_CLIENT_SERVER_URI",
    "value": "http://skipper-server:7578/api"
  },
  {
      "name": "SPRING_DATASOURCE_URL",
      "value": "jdbc:postgresql://${rds_endpoint}/${db_name}"
    },
    {
      "name": "SPRING_DATASOURCE_USERNAME",
      "value": "${db_username}"
    },
    {
      "name": "SPRING_DATASOURCE_PASSWORD",
      "value": "${db_password}"
    },
    {
      "name": "SPRING_DATASOURCE_DRIVER_CLASS_NAME",
      "value": "org.postgresql.Driver"
    }
]