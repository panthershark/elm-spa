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

# RUNDECK BUILD
When developers run `yarn version`, the src is built to dist and the repo is tagged. Since dist built cleanly and checked into git when tagged, rundeck only needs to do the following

```
yarn install
docker build ... 
```


### Development

Place a `local.env` file in the root next to package.json with development settings.

```bash
PORT=8081
DEV_SERVER_LAG=800

# PUT YOUR SETTINGS HERE
```
