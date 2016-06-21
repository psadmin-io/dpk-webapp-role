class pt_role::pt_tools_webapp inherits pt_role::pt_base {
  notify { "Applying pt_role::pt_tools_webapp": }

  $ensure   = hiera('ensure')

  contain ::pt_profile::pt_tools_deployment
  contain ::pt_profile::pt_psft_environment
  contain ::pt_profile::pt_appserver
  contain ::pt_profile::pt_pia
  contain ::pt_profile::pt_samba
  contain ::pt_profile::pt_source_details

  if $ensure == present {
    contain ::pt_profile::pt_domain_boot
  
    Class['::pt_profile::pt_system'] ->
    Class['::pt_profile::pt_tools_deployment'] ->
    Class['::pt_profile::pt_psft_environment'] ->
    Class['::pt_profile::pt_appserver'] ->
    Class['::pt_profile::pt_pia'] ->
    Class['::pt_profile::pt_samba'] ->
    Class['::pt_profile::pt_domain_boot'] ->
    Class['::pt_profile::pt_source_details']
  }
  elsif $ensure == absent {
    Class['::pt_profile::pt_source_details'] ->
    Class['::pt_profile::pt_samba'] ->
    Class['::pt_profile::pt_pia'] ->
    Class['::pt_profile::pt_appserver'] ->
    Class['::pt_profile::pt_psft_environment'] ->
    Class['::pt_profile::pt_tools_deployment'] ->
    Class['::pt_profile::pt_system']
  }
}
