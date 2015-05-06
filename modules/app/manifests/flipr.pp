class app::flipr {
  include admin::virtual
  realize(Package['apache2-mpm-worker'])
}
