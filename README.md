# Example Cookbook

This cookbook was created to showcase how certain tools work together for cookbook testing as well as provide examples of how to write a cookbook. The focus of this will be on:

#### Development

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

#### On OS X?

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
bundle exec kitchen test

# for more information
bundle exec kitchen help
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## Authors

Jordan Wesolowski (<jrwesolo@gmail.com>)
