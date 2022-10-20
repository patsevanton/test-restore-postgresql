variable "psql_service_name" {
  description = "Managed Service for PostgreSQL name"
  type        = string
  validation {
    condition     = can(regex("^[0-9A-Za-z_]*$", var.psql_service_name))
    error_message = "The psql_service_name value can contain numbers, letters and _."
  }
}

variable "psql_service_network_id" {
  description = "PostgreSQL network id"
  type        = string
}

variable "psql_service_env" {
  type    = string
  default = "PRESTABLE" # ENVIRONMENT_UNSPECIFIED, PRODUCTION, PRESTABLE
}

variable "psql_service_version" {
  type    = string
  default = 14
}

variable "psql_service_disk_type" {
  description = "PostgreSQL disk type"
  type        = string
  default     = "network-hdd" # https://cloud.yandex.com/docs/managed-postgresql/concepts/storage
}

variable "psql_service_resource_preset" {
  description = "PostgreSQL resource preset"
  type        = string
  default     = "b1.medium" # https://cloud.yandex.com/docs/managed-postgresql/concepts/instance-types
}

variable "psql_service_disk_size" {
  description = "Psql disk size GB"
  default     = 30
  type        = number
}

variable "psql_db_names" {
  description = "Psql list database names"
  type        = list(string)
}


variable "placement" {
  description = "Set zone and network"
  type = list(object({
    zone   = string
    subnet = string
  }))
}

variable "backup_hour" {
  description = "Set backup time hour"
  type        = number
  default     = 4
}

variable "backup_minute" {
  description = "Set backup time minute"
  type        = number
  default     = 0
}

variable "backup_id" {
  description = "backup id"
  type        = string
  default     = ""
}

variable "day" {
  description = "Maintenance start day"
  type        = string
  default     = "MON"
}

variable "hour" {
  description = "Maintenance start hour"
  type        = number
  default     = 1
}

variable "connection_limit" {
  description = "Database connection limit"
  type        = number
  default     = 200
}

variable "data_lens_access" {
  type        = bool
  default     = false
  description = "Datalens access"
}

variable "web_sql_access" {
  type        = bool
  default     = true
  description = "Web sql access"
}

variable "description" {
  type        = string
  default     = null
  description = "Cluster description"
}

variable "maintenance_type" {
  type        = string
  default     = "WEEKLY"
  description = "Maintenance window type"
}

variable "host_master_name" {
  type        = string
  default     = null
  description = "Master name"
}

variable "psql_user" {
  type        = string
  default     = "user"
}

variable "psql_password" {
  type        = string
}

variable "security_group_ids" {
  type        = list(string)
  default     = null
  description = "List of attached security groups id"
}

variable "user_settings" {
  type        = map(string)
  default     = null
  description = "DB user settings"
}

variable "psql_db_extensions" {
  type        = map(list(string))
  default     = null
  description = "DB extensions"
}

variable "psql_additional_users" {
  type        = map(map(list(string)))
  default     = null
  description = "Additional users"
}


variable "connection_limit_additional_user" {
  description = "Database connection limit for additional users"
  type        = number
  default     = 100
}

variable "password_length" {
  type        = number
  default     = 24
  description = "Length of users password"
}

variable "permission" {
  type        = map(string)
  default     = null
  description = "User permissions"
}


variable "yc_token" {
  type        = string
  description = "Yandex Cloud API key"
}

variable "yc_cloud_id" {
  type        = string
  description = "Yandex Cloud id"
}

variable "yc_folder_id" {
  type        = string
  description = "Yandex Cloud folder id"
}


