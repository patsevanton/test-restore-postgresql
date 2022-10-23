resource "yandex_mdb_postgresql_cluster" "test" {
  name        = "test"
  environment = "PRODUCTION"
  network_id  = "enprkje8ae9b74e0himb"

  config {
    version = "15"
    resources {
      resource_preset_id = "b1.medium"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = "e2l6251f60t5e6faq3o7"
#    assign_public_ip = true
  }
}

resource "yandex_mdb_postgresql_database" "test" {
  cluster_id = yandex_mdb_postgresql_cluster.test.id
  name       = "test"
  owner      = "test"
  depends_on = [
    yandex_mdb_postgresql_user.test
  ]
}

resource "yandex_mdb_postgresql_user" "test" {
  cluster_id = yandex_mdb_postgresql_cluster.test.id
  name       = "test"
  password   = var.psql_password
}
