# Apache Tomcat (Internal) Module

The following module installs and configures both Java and Apache Tomcat. It
mostly wraps around the external `java`, `java_ks`, and `tomcat` modules.

## `tomcat_internal` Class Reference

### Parameter Descriptions

| Parameter Name                     | Description                                                                                                                                          |
|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| `base_dir`                         | The path to the Apache Tomcat base directory.                                                                                                        |
| `ca_cert_path`                     | The path to the internal CA certificate (as provided by the `certutils` module).                                                                     |
| `catalina_home_dir`                | The path to the Catalina home directory (typically within `base_dir`).                                                                               |
| `catalina_opts`                    | An additional set of options that make up the `CATALINA_OPTS` environment variable (with the `-` prefix).                                            |
| `config_server_access_log_pattern` | The pattern associated with localhost access logs.                                                                                                   |
| `config_server_access_log_prefix`  | The prefix applied to localhost access log files.                                                                                                    |
| `config_server_access_log_suffix`  | The suffix applied to localhost access log files.                                                                                                    |
| `config_server_auto_deploy`        | The value of the `autoDeploy` attribute of the default `Host` directive within `.../conf/server.xml`.                                                |
| `config_server_connection_timeout` | The connection timeout for the `HTTP/1.1` connector within `.../conf/server.xml`.                                                                    |
| `config_server_http_listen_port`   | The insecure listen port for the `HTTP/1.1` connector within `.../conf/server.xml`.                                                                  |
| `config_server_https_listen_port`  | The secure listen port for the `HTTP/1.1` connector within `.../conf/server/xml`.                                                                    |
| `config_server_service_name`       | The name of the Catalina service defined within `.../conf/server.xml`.                                                                               |
| `config_server_unpack_war_files`   | Whether Tomcat should automatically unpack WAR files.                                                                                                |
| `current_symlink_version`          | The version of Apache Tomcat associated with the `current` symlink, corresponding to a directory within `base_dir`.                                  |
| `debug_opts`                       | An additional set of options that make up the `DEBUG_OPTS` environment variable (with the `-` prefix).                                               |
| `enable_service`                   | Whether the `tomcat` service should be enabled on boot.                                                                                              |
| `fw_allowed_source`                | If `manage_firewall` is set to `true`, allow connections from the specified address(es) to the ports defined by `config_server_http(s)_listen_port`. |
| `group`                            | The group associated with the Apache Tomcat system user.                                                                                             |
| `include_debug_service`            | Whether the module should include a `tomcat-debug` service and associated `conf/tomcat-debug.conf` file.                                             |
| `java_cacerts_dir`                 | Specifies the path to the `cacerts` directory within which the Java keystore will be located.                                                        |
| `java_home_dir`                    | The path for which to set the `JAVA_HOME` environment variable.                                                                                      |
| `java_opts`                        | An additional set of options that make up the `JAVA_OPTS` environment variable (without the `-` prefix).                                             |
| `java_package`                     | The name of the Java package to install.                                                                                                             |
| `java_version`                     | The version of the package specified in `java_package` to install.                                                                                   |
| `manage_catalina_home`             | Whether to manage the Catalina home directory (or just let the package handle it).                                                                   |
| `manage_catalina_properties`       | Whether to manage the contents of `catalina.properties`.                                                                                             |
| `manage_conf`                      | Whether to manage `tomcat.conf` within `tomcat_conf_dir`.                                                                                            |
| `manage_current_symlink`           | Whether to manage the `current` symlink.                                                                                                             |
| `manage_firewall`                  | Whether to manage any `firewall` resources associated with this module.                                                                              |
| `manage_group`                     | Whether to manage the Tomcat system group (or just let the package handle it).                                                                       |
| `manage_rsyncd`                    | Whether to include the default `rsync` modules associated with this Puppet module.                                                                   |
| `manage_rsyslog`                   | Whether to manage any relevant `rsyslog::imfile` resources.                                                                                          |
| `manage_service`                   | Whether to enable management of the `tomcat` service.                                                                                                |
| `manage_ulimits`                   | Whether to manage ulimits related to Apache Tomcat via the `ulimits` module.                                                                         |
| `manage_user`                      | Whether to manage the Tomcat system user (or just let the package handle it).                                                                        |
| `manage_xml`                       | Whether to manage the various XML files within the base configuration directory (such as `.../conf/server.xml`).                                     |
| `package`                          | The name of the Apache Tomcat package to install.                                                                                                    |
| `rsyncd_allowed_hosts`             | The collection of hosts for which to allow access to `rsyncd` modules associated with this Puppet module.                                            |
| `rsyslog_imfiles`                  | Specifies the `Hash` of `rsyslog::imfile` resources to apply. See `data/common.yaml` for more information.                                           |
| `tomcat_conf_dir`                  | The path to the current base Tomcat layout's configuration directory.                                                                                |
| `tomcat_home_dir`                  | The path to the home directory of the Tomcat system user.                                                                                            |
| `tomcat_webapps_dir`               | The path to the Apache Tomcat `webapps` directory.                                                                                                   |
| `ulimits`                          | (see `data/common.yaml`)                                                                                                                             |
| `umask`                            | Specifies the value of the `UMASK` environment variable within `conf/tomcat.conf`.                                                                   |
| `user`                             | The name of the Apache Tomcat system user.                                                                                                           |
| `version`                          | The version of the specified Apache Tomcat `package` to install.                                                                                     |

### Parameter Values

| Parameter Name                     | Value Type                                      | Default Value (Hiera)                             |
|------------------------------------|-------------------------------------------------|---------------------------------------------------|
| `base_dir`                         | `Stdlib::Absolutepath`                          | `'/www/tomcat/base'`                              |
| `ca_cert_path`                     | `Stdlib::Absolutepath`                          | `"%{lookup('certutils::certs_dir')}/example.crt"` |
| `catalina_home_dir`                | `Stdlib::Absolutepath`                          | `'/www/tomcat/base/current'`                      |
| `catalina_opts`                    | `Array[String]`                                 | (see `data/common.yaml`)                          |
| `config_server_access_log_pattern` | `String`                                        | `'%h %l %u %t &quot;%r&quot; %s %b'`              |
| `config_server_access_log_prefix`  | `String`                                        | `'localhost_access_log'`                          |
| `config_server_access_log_suffix`  | `String`                                        | `'.txt'`                                          |
| `config_server_auto_deploy`        | `Boolean`                                       | `true`                                            |
| `config_server_connection_timeout` | `Integer`                                       | `20000`                                           |
| `config_server_http_listen_port`   | `Stdlib::Port`                                  | `8080`                                            |
| `config_server_https_listen_port`  | `Stdlib::Port`                                  | `8443`                                            |
| `config_server_service_name`       | `String`                                        | `'Catalina'`                                      |
| `config_server_unpack_war_files`   | `Boolean`                                       | `true`                                            |
| `current_symlink_version`          | `Pattern[/\d+\.\d+\.\d+/]`                      | `'9.0.38'`                                        |
| `debug_opts`                       | `Array[String]`                                 | (see `data/common.yaml`)                          |
| `enable_service`                   | `Boolean`                                       | `true`                                            |
| `fw_allowed_source`                | `Stdlib::IP::Address`                           | `'10.0.0.0/8'`                                    |
| `group`                            | `String`                                        | `'tomcat'`                                        |
| `include_debug_service`            | `Boolean`                                       | `true`                                            |
| `java_cacerts_dir`                 | `Stdlib::Absolutepath`                          | `'/etc/pki/java/cacerts'`                         |
| `java_home_dir`                    | `Stdlib::Absolutepath`                          | `'/usr/lib/jvm/jre'`                              |
| `java_opts`                        | `Array[String]`                                 | (see `data/common.yaml`)                          |
| `java_package`                     | `String`                                        | `'java-11-openjdk'`                               |
| `java_version`                     | `String`                                        | `'latest'`                                        |
| `manage_catalina_home`             | `Boolean`                                       | `false`                                           |
| `manage_catalina_properties`       | `Boolean`                                       | `false`                                           |
| `manage_conf`                      | `Boolean`                                       | `true`                                            |
| `manage_current_symlink`           | `Boolean`                                       | `true`                                            |
| `manage_firewall`                  | `Boolean`                                       | `true`                                            |
| `manage_group`                     | `Boolean`                                       | `false`                                           |
| `manage_rsyncd`                    | `Boolean`                                       | `true`                                            |
| `manage_rsyslog`                   | `Boolean`                                       | `true`                                            |
| `manage_service`                   | `Boolean`                                       | `true`                                            |
| `manage_ulimits`                   | `Boolean`                                       | `true`                                            |
| `manage_user`                      | `Boolean`                                       | `false`                                           |
| `manage_xml`                       | `Boolean`                                       | `true`                                            |
| `package`                          | `String`                                        | `'tomcat'`                                        |
| `rsyncd_allowed_hosts`             | `Array[Stdlib::IP::Address]`                    | `['127.0.0.1', '10.0.0.0/8']`                     |
| `rsyslog_imfiles`                  | `Hash[Stdlib::Absolutepath, Hash]`              | (see `data/common.yaml`)                          |
| `tomcat_conf_dir`                  | `Stdlib::Absolutepath`                          | `'/www/tomcat/base/current/conf'`                 |
| `tomcat_home_dir`                  | `Stdlib::Absolutepath`                          | `'/www/tomcat/home'`                              |
| `tomcat_webapps_dir`               | `Stdlib::Absolutepath`                          | `'/www/tomcat/webapps'`                           |
| `ulimits`                          | `Hash[Ulimits::Item, Array[Ulimits::Value, 2]]` | (see `data/common.yaml`)                          |
| `umask`                            | `Pattern[/\d{3,4}/]`                            | `'0022'`                                          |
| `user`                             | `String`                                        | `'tomcat'`                                        |
| `version`                          | `String`                                        | `'latest'`                                        |
