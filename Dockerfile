FROM node:alpine3.17

#Finish remaining steos in order to successfully build Docker-image

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available) into the container
COPY package*.json ./

# Install any needed packages specified in package.json
RUN npm install

# Bundle your app's source code inside the Docker image
COPY app.js app.js

# Make port 3000 available to the world outside this container
EXPOSE 8080

# Define the command to run your app using CMD which defines your runtime
CMD [ "node", "app.js" ]

