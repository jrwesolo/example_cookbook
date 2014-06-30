# Example Cookbook

This cookbook was created to showcase how certain tools work together for cookbook testing as well as provide examples of how to write a cookbook. The focus of this will be on:

#### Development

* [berkshelf](http://berkshelf.com)
* [test-kitchen](https://github.com/test-kitchen/test-kitchen)
* [docker](http://www.docker.com/whatisdocker)

#### Linting

* [rubocop](https://github.com/bbatsov/rubocop)
* [foodcritic](https://github.com/acrmp/foodcritic)

#### Testing

* [chefspec](https://github.com/sethvargo/chefspec) (unit or intention testing)
* [serverspec](https://github.com/serverspec/serverspec) (integration testing)

## Supported Platforms

Tested specifically on CentOS. It should work on Ubuntu, but there were issues with the images that were being tested on.

## Docker or Vagrant?

Both docker and vagrant are great tools when used in conjunction with test-kitchen. `.kitchen.local.yml` can be used to override `.kitchen.yml` settings. It will reside in the same directory as `.kitchen.yml` and should not be checked in to version control.

### Use Docker

The `.kitchen.yml` is already configured to use docker as the test-kitchen driver.

##### On OS X?

_If needed, here is a [guide](https://github.com/jrwesolo/docker_osx) for installing docker on OS X._

If you are on OS X, you will need to make sure that test-kitchen does not use sudo and knows the correct docker host. You can use the following `.kitchen.local.yml` for OS X support:

```yaml
---
driver:
  name: docker

driver_config:
  use_sudo: false
  socket: <%= ENV['DOCKER_HOST'] %>
```

### Use Vagrant

```yaml
---
driver:
  name: vagrant

platforms:
  - name: centos-6.5
```

## Attributes

| Key | Type | Description | Default |
| --- | ---- | ----------- | ------- |
| `['lighttpd']['config_file']` | String | location of lighttpd configuration file | `/etc/lighttpd/lighttpd.conf` |
| `['lighttpd']['document_root']` | String | document root for lighttpd server | `/var/www/example/` |
| `['lighttpd']['message']` | String | message to display on index.html | `This is a test deployment via Chef` |
| `['lighttpd']['port']` | Integer | port to use for lighttpd server | `8080` |

## Usage

### example_cookbook::default

Include `example_cookbook` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[example_cookbook::default]"
  ]
}
```

## Berkshelf

This tool is used automatically by test-kitchen for cookbook dependency management. This is very useful when your cookbook depends on external community cookbooks. Berkshelf can download these dependencies and store them locally for cookbook development and testing. It can also be used to upload your cookbook and any dependencies to your Chef server.

You can also provide different sources for Berkshelf to look for dependencies. It can be useful to host your own [Berkshelf API](https://github.com/berkshelf/berkshelf-api) server to resolve dependencies using your own Chef server.

Please read about Berkshelf [here](http://berkshelf.com) to see the format and capabilities of the `Berksfile`.

## Linting

Both `rubocop` and `foodcritic` are linting tools designed to help catch issues with styling, error-prone design, and other bad practices. It also helps multiple developers working on the same project to have a similar coding style. This is a huge benefit for maintenance and readability.

### Rubocop

```bash
bundle exec rubocop
```

### Foodcritic

```bash
bundle exec foodcritic .
```

## Testing

### ChefSpec

This tool allows you to write unit or intention tests for cookbooks. This will allow for rapid verification of possible regression through simulating the convergence of resources on a node.

```bash
bundle exec rspec
```

### ServerSpec

This tool allows you to write integration tests that can be executed against a truly converge node (not simulated like ChefSpec). When using test-kitchen, these tests will automatically be executed at the end of a `bundle exec kitchen test` or `bundle exec kitchen verify`.

### Test Kitchen

> Test Kitchen is an integration tool for developing and testing infrastructure code and software on isolated target platforms.

Test Kitchen will be able to provision, converge, test, and destroy your testing environment automatically. It is a much more robust development workflow than vagrant alone.

```bash
bundle exec kitchen list
bundle exec kitchen test
# for more information
bundle exec kitchen help
```

#### Common Errors

##### /var/run/docker.sock: no such file or directory

This means that the DOCKER_HOST variable is not set correctly. If on OS X, please see this [guide](https://github.com/jrwesolo/docker_osx).

##### You must first isntall the Docker CLI tool

If on OS X, it usually means that `.kitchen.local.yml` was not configured to make sure that sudo is not used with the docker command. Please see the `Use Docker > On OS X?` section above.

Running the test kitchen command that threw the error with a `-l debug` should provide more troubleshooting information.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## Authors

Jordan Wesolowski (<jrwesolo@gmail.com>)
