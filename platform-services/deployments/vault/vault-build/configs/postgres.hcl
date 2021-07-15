storage "postgresql" {
  connection_url="postgres://${PG_USER}:${PG_PASSWORD}@${PG_SVC}:5432/${PG_DB}?sslmode=disable"
  table="vault_kv_store",
  ha_enabled=true,
  ha_table="vault_ha_locks"
}