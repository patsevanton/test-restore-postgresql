resource "yandex_mdb_postgresql_cluster" "test3" {
  name        = "test3"
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
    zone             = "ru-central1-b"
    subnet_id        = "e2l6251f60t5e6faq3o7"
    assign_public_ip = true
  }

  restore {
    backup_id = "c9q98l1c157oobcpvln9:c9qr97e0eust80v20o7f"
  }
}