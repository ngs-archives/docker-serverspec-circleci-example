require 'serverspec'
require 'docker'
require 'open3'

set :backend, :docker
set :os, family: 'ubuntu', arch: 'x86_64'
if ENV['DOCKER_IMAGE']
  set :docker_image, ENV['DOCKER_IMAGE']
elsif ENV['DOCKER_CONTAINER']
  set :docker_container, ENV['DOCKER_CONTAINER']
end

# TODO https://github.com/swipely/docker-api/issues/202
Excon.defaults[:ssl_verify_peer] = false

# https://circleci.com/docs/docker#docker-exec
if ENV['CIRCLECI']
  module Docker
    class Container
      def remove(options={})
        # do not delete container
      end
      alias_method :delete, :remove
    end
  end
end
