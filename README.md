#How to use

##CLI

###Usage

We can check which command are available and what is the syntax with `./deployer.rb`


```
deployer.rb check --host=SERVER           # check if drupal isreachable on the defined ip and port
deployer.rb create --stackname=STACKNAME  # create AWS stack
deployer.rb delete --stackname=STACKNAME  # delete AWS stack
deployer.rb help [COMMAND]                # Describe available commands or one specific command
```

###Examples

```
./deployer.rb check --host=35.125.34.2
```

```
./debployer.rb create --stackname=drupal-stack --config=~/AWS/config.yml
```

```
./deployer.rb delete --stackname=drupal-stack
```

##REST API

###Start the webservice

```bash
./service.rb
```

###Endpoints

| Method | Endpoint | Description |
| ------ | -------- | ----------- |
| POST   | /:stackname | Creates a stack |
| DELETE | /:stackname | Deletes a stack |
| GET    | /check/:host | Checks if drupal is running on the server. |