%if 0%{?copr}
%define build_timestamp .%(date +"%Y%m%d%H%M%%S")
%else
%define build_timestamp %{nil}
%endif

Name: apb-base-scripts
Version:	1.0.0
Release:	1%{build_timestamp}%{?dist}
Summary:	Scripts for the apb-base container image

License:	ASL 2.0
URL:		https://github.com/fusor/apb-examples
Source0:	https://github.com/fusor/apb-examples/archive/apb-examples-%{version}.tar.gz
BuildArch:  noarch

%description
%{summary}

%prep
%setup -q -n %{name}-%{version}

%install
mkdir -p %{buildroot}%{_bindir}
install -m 755 apb-base/entrypoint.sh %{buildroot}%{_bindir}
install -m 755 apb-base/oc-login.sh %{buildroot}%{_bindir}

%files
%doc
%{_bindir}/entrypoint.sh
%{_bindir}/oc-login.sh

%changelog
