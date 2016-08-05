# Define: puppet::fact
#
# define for setting facts using facter.d
#

define puppet::fact (
  $value,
  $ensure = present,
  ) {
  include ::puppet::defaults
  include ::puppet
  $facterbasepath = $::puppet::defaults::facterbasepath
  $puppet_group   = $::puppet::puppet_group

  validate_string($title)
  $facter_data = { "${title}" => $value }

  file { "${facterbasepath}/facts.d/${title}.yaml":
    ensure  => $ensure,
    owner   => 'root',
    group   => $puppet_group,
    mode    => '0640',
    content => template('puppet/fact.yaml.erb'),
  }

}
