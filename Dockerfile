FROM photon:3.0

# Set the working directory inside the container
WORKDIR /app

# Copy the necessary files to the container
COPY . /app

RUN tdnf install -y openjdk8 nodejs-9.11.2-1.ph3

#RUN echo 0 99999999 | tee /proc/sys/net/ipv4/ping_group_range

RUN npm set registry http://build-artifactory.eng.vmware.com/artifactory/api/npm/npm
RUN npm install -g npm@5.6.0

# Run the Gradle build
RUN ./gradlew build

EXPOSE 8080
# Run the npm start command
CMD ["./gradlew", "npm_start"]
