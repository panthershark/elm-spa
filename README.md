# ELM SPA
App starter kit with the following services integrated.

* Server api
* Elm single page app with push state
* Basic models and messages
* Build for Elm and Sass via webpack.
* Dev server and production servers
* Dockerfile

# INSTALL 

The app

```
npm run reinstall
npm start
```

Just the API

```
npm run start:api
```

# DOCKER BUILD
Use the following to build and create a container with you app.

```
yarn run reinstall
yarn run build
yarn install --production
docker build --tag elmspa --build-arg port=8081 .

docker run -d -p 9030:8081  elmspa 
```

#### INJECT RUNTIME ENV CONFIG

```
docker run --name=myapp -d -p 9030:8081 -v "/path-to-production-config/configuration-file.env:/usr/src/app/local.env" elmspa 
```


### Development

Place a `local.env` file in the root next to package.json with development settings.

```bash
PORT=8081
DEV_SERVER_LAG=800
PUBLIC_PATH=/elm-spa

# PUT YOUR SETTINGS HERE
```
