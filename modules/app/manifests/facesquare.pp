class app::facesquare {
  include admin::virtual
  realize(Package['apache2-mpm-worker'])
}
