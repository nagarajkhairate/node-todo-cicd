# Use Node.js 12 image as base
FROM node:12.2.0-alpine

# Set working directory inside the container
WORKDIR /node

# Update npm to the latest version
RUN npm install -g npm@latest

# Copy package.json and package-lock.json first (for better cache usage)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Expose the app port
EXPOSE 8000

# Run the app
CMD ["node", "app.js"]
