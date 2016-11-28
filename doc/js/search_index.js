var search_data = {"index":{"searchIndex":["awsclient","awscred","drupalcli","main","object","/:name()","/check/:host()","check()","check_if_drupal_is_up()","check_stack_status()","create()","create_stack()","create_stack()","delete()","delete_stack()","delete_stack()","new()","new()","new()","print_status()","read_config()","whirly_status()","aws.template","readme","created.rid","apache2.conf","drupal.pp","puppet.conf","site.pp"],"longSearchIndex":["awsclient","awscred","drupalcli","main","object","object#/:name()","object#/check/:host()","drupalcli#check()","main#check_if_drupal_is_up()","awsclient#check_stack_status()","drupalcli#create()","awsclient#create_stack()","main#create_stack()","drupalcli#delete()","awsclient#delete_stack()","main#delete_stack()","awsclient::new()","awscred::new()","drupalcli::new()","object#print_status()","main#read_config()","object#whirly_status()","","","","","","",""],"info":[["AWSClient","","AWSClient.html","","<p>This class implements the communication with AWS CloudFormation API\n"],["AWSCred","","AWSCred.html","","<p>Object which stores the AWS credential data\n"],["DrupalCLI","","DrupalCLI.html","","<p>CLI class, inherited from THOR\n"],["Main","","Main.html","","<p>Class which contains main functionalities of the program\n"],["Object","","Object.html","",""],["/:name","Object","Object.html#method-i-2F-3Aname","","<p>Create stack with POST method and stackname parameter\n"],["/check/:host","Object","Object.html#method-i-2Fcheck-2F-3Ahost","","<p>Checks if drupal is up on host, with GET method\n"],["check","DrupalCLI","DrupalCLI.html#method-i-check","()","<p>Calls the main class&#39;s check_if_drupal_is_up function and based on the\nstatus it prints if drupal …\n"],["check_if_drupal_is_up","Main","Main.html#method-i-check_if_drupal_is_up","(server)",""],["check_stack_status","AWSClient","AWSClient.html#method-i-check_stack_status","(credentials)","<p>Checks the stack status via AWS CloudFormation client\n"],["create","DrupalCLI","DrupalCLI.html#method-i-create","()","<p>Calls the main class&#39;s create_stack function after it reads the\nconfiguration from the config file …\n"],["create_stack","AWSClient","AWSClient.html#method-i-create_stack","()","<p>Creates stack via AWS CloudFormation client\n"],["create_stack","Main","Main.html#method-i-create_stack","(stackname)",""],["delete","DrupalCLI","DrupalCLI.html#method-i-delete","()","<p>Calls the main class&#39;s delete_stack function after it reads the\nconfiguration from the config file …\n"],["delete_stack","AWSClient","AWSClient.html#method-i-delete_stack","()","<p>Deletes stack via AWS CloudFormation client\n"],["delete_stack","Main","Main.html#method-i-delete_stack","(stackname)",""],["new","AWSClient","AWSClient.html#method-c-new","(credentials, stack_name)","<p>Initialize the AWS CloudFormation client\n"],["new","AWSCred","AWSCred.html#method-c-new","(credentials)","<p>Initialize the credential obcjet which stores AWS credentail data\n"],["new","DrupalCLI","DrupalCLI.html#method-c-new","(*args)",""],["print_status","Object","Object.html#method-i-print_status","(client, condition, stackname, credentials)","<p>Prints the current status of the process with whirly progress bar\n"],["read_config","Main","Main.html#method-i-read_config","(config_file = File.join(__dir__, 'config.yml'))",""],["whirly_status","Object","Object.html#method-i-whirly_status","(condition, stackname)","<p>Decides if the process is deletation or creation\n"],["aws.template","","CLI/aws_template.html","","<p>{\n\n<pre>&quot;Resources&quot; : {\n  &quot;LaunchConfig&quot; : {\n    &quot;Type&quot; : &quot;AWS::AutoScaling::LaunchConfiguration&quot;,\n      &quot;Properties&quot; ...</pre>\n"],["README","","README_md.html","","<p>How to use\n<p>CLI\n<p>Usage\n"],["created.rid","","doc/created_rid.html","",""],["apache2.conf","","s3_files/apache2_conf.html","","<p># Security ServerTokens OS ServerSignature On TraceEnable On\n<p>ServerName “ip-172-31-1-123.eu-central-1.compute.internal” …\n"],["drupal.pp","","s3_files/drupal_pp.html","","<p>exec { &#39;php_xml&#39;:\n\n<pre class=\"ruby\">  <span class=\"ruby-identifier\">command</span> =<span class=\"ruby-operator\">&gt;</span> <span class=\"ruby-string\">&#39;/usr/bin/apt-get install php-xml -y&#39;</span>\n}\n</pre>\n<p>exec { &#39;install_drush&#39;: …\n"],["puppet.conf","","s3_files/puppet_conf.html","","<p>main &mdash; logdir=/var/log/puppet vardir=/var/lib/puppet ssldir=/var/lib/puppet/ssl\nrundir=/var/run/puppet …\n\n"],["site.pp","","s3_files/site_pp.html","","<p>class { &#39;apache&#39;:                # use the “apache” module\n\n<pre class=\"ruby\"><span class=\"ruby-identifier\">default_vhost</span> =<span class=\"ruby-operator\">&gt;</span> <span class=\"ruby-keyword\">false</span>,  <span class=\"ruby-operator\">...</span>\n</pre>\n"]]}}