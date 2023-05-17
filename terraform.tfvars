region                               = "us-east-1"
environment                          = "dev"
vpc_tag_name                         = "vpc"
number_of_private_subnets            = 2
private_subnet_tag_name              = "private-subnet"
public_subnet_tag_name               = "public-subnet"
vpc_cidr_block                       = "11.0.0.0/16"
private_subnet_cidr_blocks           = ["11.0.1.0/24", "11.0.2.0/24"]
public_subnet_cidr_blocks            = ["11.0.4.0/24", "11.0.5.0/24"]
availability_zones                   = ["us-east-1a", "us-east-1b"]
security_group_ecs_tasks_name        = "ecs-tasks-sg"
security_group_ecs_tasks_description = "allow inbound access from vpc only"

namespace        = "devCluster"
cluster_tag_name = "devCluster"
app_count        = "1"


#dataflow server config
app_image_home                     = "163115913121.dkr.ecr.us-east-1.amazonaws.com/my-repo:dataflow"
home_dns_name                      = "dataflow-server"
home_family_name                   = "dataflow-server"
home_container_name                = "dataflow-server"
home_port_mapping                  = "dataflow-server"
app_port_home                      = 9393
tg_name_home                       = "dataflow-server-tg"
security_group_ecs_tasks_name_home = "dataflow-server-task-sg"
dataflow_env_file                  = "container-config/dataflow.tpl"

#skipper server config
app_image_movie                     = "163115913121.dkr.ecr.us-east-1.amazonaws.com/my-repo:skipper"
movie_dns_name                      = "skipper-server"
movie_family_name                   = "skipper-server"
movie_container_name                = "skipper-server"
movie_port_mapping                  = "skipper-server"
app_port_movie                      = 7577
tg_name_movie                       = "skipper-server-tg"
security_group_ecs_tasks_name_movie = "skipper-server-ecs-task-sg"
skipper_env_file                    = "container-config/skipper.tpl"


#kafka-console server config
app_image_kafka_console                     = "163115913121.dkr.ecr.us-east-1.amazonaws.com/my-repo:console"
kafka_console_dns_name                      = "kafka-console"
kafka_console_family_name                   = "kafka-console"
kafka_console_container_name                = "kafka-console"
kafka_console_port_mapping                  = "kafka-console"
app_port_kafka_console                      = 8080
tg_name_kafka_console                       = "kafka-console-tg"
security_group_ecs_tasks_name_kafka_console = "kafka console ecs task sg"
kafka_console_env_file                      = "container-config/kafka-console.tpl"



# database variables
parameter_group_name            = "parameter-grp-db"
parameter_group_family          = "postgres14"
db_username                     = "postgres"
db_password                     = "postgres123456"
db_port                         = 5432
db_name                         = "dataflow"
allocated_storage               = 100
max_allocated_storage           = 500
storage_type                    = "io1"
instance_class                  = "db.t3.medium"
skip_final_snapshot             = true
multi_az                        = false
enabled_cloudwatch_logs_exports = false
param_log_statement             = "none"
