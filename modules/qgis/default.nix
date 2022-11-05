{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    (qgis.override {
      extraPythonPackages = (ps: [
        ps.python-dateutil
        ps.future
        ps.gdal
        ps.httplib2
        ps.jinja2
        ps.lxml
        ps.markupsafe
        ps.matplotlib
        ps.owslib
        ps.plotly
        ps.psycopg2
        ps.pygments
        ps.pyproj
        ps.pyqt5
        ps.requests
        ps.sip
        ps.six
      ]);
    })
    grass
    libspatialite
  ];
}
