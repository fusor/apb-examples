%if 0%{?copr}
%define build_timestamp .%(date +"%Y%m%d%H%M%%S")
%else
%define build_timestamp %{nil}
%endif

Name: mediawiki-apb-role
Version:	1.0.1
Release:	1%{build_timestamp}%{?dist}
Summary:	Ansible Playbook for Mediawiki APB

License:	ASL 2.0
URL:		https://github.com/fusor/apb-examples
Source0:	https://github.com/fusor/apb-examples/archive/%{name}-%{version}.tar.gz
BuildArch:  noarch

%description
%{summary}

%prep
%setup -q -n %{name}-%{version}

%install
mkdir -p %{buildroot}/opt/apb/ %{buildroot}/opt/ansible/
mv playbooks %{buildroot}/opt/apb/actions
mv roles %{buildroot}/opt/ansible/roles

%files
%doc
/opt/apb/actions
/opt/ansible/roles

%changelog
* Fri Jul 07 2017 Jason Montleon <jmontleo@redhat.com> 1.0.1-1
- 1468199 Change Mediawiki PVC to ReadWriteOnce

* Tue Jun 06 2017 Jason Montleon <jmontleo@redhat.com> 1.0.0-1
- Initial Build
