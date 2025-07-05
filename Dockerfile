# Use Ruby 3.4.1 as the base image
FROM ruby:3.4.1-slim

# Set working directory
WORKDIR /app

# Install system dependencies and security updates
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    build-essential \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install

# Copy the rest of the application
COPY . .

# Expose port 4000 (default Jekyll port)
EXPOSE 4000

# Set the default command to serve the site
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000"] 