# ELM SPA
A truly production ready elm application starter kit for "single page apps" (i.e. websites with a lot of pages that use history api). The following features are integrated.

* Server api
* Elm single page app with push state
* MaterializeCSS though you can easily rip it out and use what you like.
* Basic models and messages
* Build for Elm and Sass via webpack.
* Dev server and production servers
* Dockerfile

# BACKGROUND
We have multiple single page apps in production using these foundational patterns. By patterns, I literally took our internal app starter and removed the stuff like api libraries, db drivers, auth0 integration, etc. I left all of the code organization stuff and did not go overboard with demo features... yet :)

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

# HOW DO I USE THIS FOR MY APP
Generally speaking, you should get started by doing the following:

* integrate authentication flow/middleware in `./server/main.js` and get your login working
* get `./server/api/services/user` to return the current user from the auth middleware integrated above
* start writing elm. 
  - this is an app so we put all models in the Api.Models module. you can split them into separate files, but we find that complicates maintenance
  - as you add server apis, setup models, decoders, and cmds. 
  - for each new page route, there is some boilerplate to add. (TODO: explain this)


# WHAT IS PageModel Model?
When making an app, you'll likely share data between "pages." If the data is available and the new route can use it to render the intial frame, the app can avoid jumpy-ness or FOUC (flash of unstyled content). 

You have a few choices here. The common data can live on Main.elm and get passed around or you can use Elm records to store common things that are passed into each Page.init. IF you don't like using records, that's cool!  Simply remove the PageModel stuff from Api.Models and the compiler will help you find all changes. 