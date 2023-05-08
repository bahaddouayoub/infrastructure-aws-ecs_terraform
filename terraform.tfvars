region                               = "us-east-1"
environment                          = "prod"
vpc_tag_name                         = "ecs-cluster"
number_of_private_subnets            = 2
private_subnet_tag_name              = "private-subnet"
vpc_cidr_block                       = "11.0.0.0/16"
private_subnet_cidr_blocks           = ["11.0.1.0/24", "11.0.4.0/24", "11.0.3.0/24"]
availability_zones                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
security_group_lb_name               = "alb-sg"
security_group_ecs_tasks_name        = "ecs-tasks-sg"
security_group_lb_description        = "allow inbound access from vpc only"
security_group_ecs_tasks_description = "allow inbound access from alb security group only"

namespace        = "devCluster"
cluster_tag_name = "ecs-dev-cluster"
app_count        = "1"


#dataflow server config
app_image_home                     = "732230631636.dkr.ecr.us-east-1.amazonaws.com/datflow-skipper:dataflow"
home_dns_name                      = "dataflow-server"
home_family_name                   = "dataflow-server"
home_container_name                = "dataflow-server"
home_port_mapping                  = "dataflow-server"
app_port_home                      = 9393
health_check_path_home             = "/"
tg_name_home                       = "dataflow-server-tg"
security_group_ecs_tasks_name_home = "dataflow-server-task-sg"
kafka_env_file                     = "container-config/dataflow.json"

#skipper server config
app_image_movie                     = "732230631636.dkr.ecr.us-east-1.amazonaws.com/datflow-skipper:skipper"
health_check_path_movie             = "/api"
movie_dns_name                      = "skipper-server"
movie_family_name                   = "skipper-server"
movie_container_name                = "skipper-server"
movie_port_mapping                  = "skipper-server"
app_port_movie                      = 7577
tg_name_movie                       = "skipper-server-tg"
security_group_ecs_tasks_name_movie = "skipper-server-ecs-task-sg"
skipper_env_file                    = "container-config/skipper.json"



# database variables
parameter_group_name            = "parameter-grp-db"
parameter_group_family          = "postgres14"
db_username                     = "postgres"
db_password                     = "postgres123456"
db_port                         = 5432
allocated_storage               = 100
max_allocated_storage           = 500
storage_type                    = "io1"
instance_class                  = "db.t3.medium"
skip_final_snapshot             = false
multi_az                        = false
enabled_cloudwatch_logs_exports = true
param_log_statement             = "none"
