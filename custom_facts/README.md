# Custom Facts Module

The following module simply serves to provide additional top-level Puppet facts
to Facter. The table below describes each of these additional facts. The scripts
themselves may be found within the `facts.d/` subdirectory.

| Fact Name       | Description                                                    | Example Value          |
|-----------------|----------------------------------------------------------------|------------------------|
| `base_hostname` | The hostname of the current node without any trailing numbers. | `example-node-number-` |
