FROM node:8-alpine
ARG port

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY . /usr/src/app/
RUN ls -al /usr/src/app/

EXPOSE ${port}
ENV DOTENV=/usr/src/app/local.env
CMD [ "npm", "run", "start:prod" ]
