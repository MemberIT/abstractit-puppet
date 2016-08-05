# Class: puppet::facts
#
# Setup puppet facts
#
# setup facts
#

class puppet::facts (
  $custom_facts = undef
) {
  include ::puppet
  include ::puppet::defaults
  $facterbasepath = $::puppet::defaults::facterbasepath
  $puppet_group   = $::puppet::puppet_group

  if $custom_facts {
    validate_hash($custom_facts)
  }

  file { "${facterbasepath}/facts.d/local.yaml":
    ensure  => file,
    owner   => 'root',
    group   => $puppet_group,
    mode    => '0640',
    content => template('puppet/local_facts.yaml.erb'),
  }

}
