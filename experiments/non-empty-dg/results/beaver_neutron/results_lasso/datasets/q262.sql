INSERT INTO "ports" ("tenant_id", "id", "name", "network_id", "mac_address", "admin_state_up", "status", "device_id", "device_owner", "dns_name", "standard_attr_id") VALUES ('17ea94ad74b64b9d92f4888336a598c7', 'purpose', 'Patrick Sanchez', 'chair', '600 Jeffery Parkways
New Jamesside, MT 29394', 1001, 'DOWN', 'list', 'perform', 'Sean Blake', 1002);
INSERT INTO "qos_port_policy_bindings" ("policy_id", "port_id") VALUES ('collection', 'purpose');
INSERT INTO "securitygroupportbindings" ("port_id", "security_group_id") VALUES ('purpose', '0008e629-5619-41e0-b86c-4eecfeaacb6c');
