resource "yandex_mdb_postgresql_cluster" "test2" {
  name        = "test2"
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
    assign_public_ip = true
  }

}

resource "yandex_mdb_postgresql_database" "test2" {
  cluster_id = yandex_mdb_postgresql_cluster.test2.id
  name       = "test2"
  owner      = "test2"
  depends_on = [
    yandex_mdb_postgresql_user.test2
  ]
}

resource "yandex_mdb_postgresql_user" "test2" {
  cluster_id = yandex_mdb_postgresql_cluster.test2.id
  name       = "test2"
  password   = var.psql_password
}
