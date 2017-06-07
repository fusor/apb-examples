%if 0%{?copr}
%define build_timestamp .%(date +"%Y%m%d%H%M%%S")
%else
%define build_timestamp %{nil}
%endif

Name: mediawiki-apb-role
Version:	1.0.0
Release:	1%{build_timestamp}%{?dist}
Summary:	Ansible Playbook for Mediawiki APB

License:	ASL 2.0
URL:		https://github.com/fusor/apb-examples
Source0:	https://github.com/fusor/apb-examples/archive/apb-examples-%{version}.tar.gz
BuildArch:  noarch

%description
%{summary}

%prep
%setup -q -n %{name}-%{version}

%install
mkdir -p %{buildroot}/opt/apb/ %{buildroot}/opt/ansible/
mv mediawiki123-apb/playbooks %{buildroot}/opt/apb/actions
mv mediawiki123-apb/roles %{buildroot}/opt/ansible/roles

%files
%doc
/opt/apb/actions
/opt/ansible/roles

%changelog
