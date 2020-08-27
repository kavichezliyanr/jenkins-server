# Auto create jenkins instance
 This project allows us to create a jenkins instance in minutes.
 
## Steps to configuration 
### DockerFile
Created docker configuration file for jenkins instance where it will pull the jenkins latest image for the configuration

### Proxy Setup
If any proxy bypass is requried we can pass the http proxy / https proxy / No proxy configurations

```
ARG HTTP_PROXY

ENV HTTP_PROXY ${HTTP_PROXY}
ENV HTTPS_PROXY ${HTTP_PROXY}
ENV http_proxy ${HTTP_PROXY}
ENV https_proxy ${HTTP_PROXY}
ENV NO_PROXY=.example.com

```

### PluginFile 
Add all the packages required for auto download plugins on configuration.

```
ace-editor:latest
artifactory:latest
sonar:latest
maven-plugin:latest 
mailer:latest 

```

### Admin Account
on startup of jenkins instance we required to create a account manually. which we can automate by groovy script for user creation.

```
def instance = Jenkins.getInstance()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", "pass")
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)
instance.save()

Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)

```
Add the configuration file to docker file

```
COPY user.groovy /usr/share/jenkins/ref/init.groovy.d/user.groovy

```
