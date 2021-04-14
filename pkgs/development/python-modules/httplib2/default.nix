{ lib
, buildPythonPackage
, fetchFromGitHub
, isPy27
, mock
, pyparsing
, pytest-forked
, pytest-randomly
, pytest-timeout
, pytest-xdist
, pytestCheckHook
, six
}:

buildPythonPackage rec {
  pname = "httplib2";
  version = "0.19.1";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-e0Mq9AVJEWQ9GEtYFXk2fMIs7GtAUsyJN6XheqAnD3I=";
  };

  postPatch = ''
    sed -i "/--cov/d" setup.cfg
  '';

  propagatedBuildInputs = [ pyparsing ];

  checkInputs = [
    mock
    pytest-forked
    pytest-randomly
    pytest-timeout
    pytest-xdist
    six
    pytestCheckHook
  ];

  # Don't run tests for Python 2.7
  doCheck = !isPy27;
  pytestFlagsArray = [ "--ignore python2" ];
  pythonImportsCheck = [ "httplib2" ];

  meta = with lib; {
    description = "A comprehensive HTTP client library";
    homepage = "https://httplib2.readthedocs.io";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
