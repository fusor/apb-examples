FROM ansibleplaybookbundle/apb-base

LABEL "com.redhat.apb.version"="0.1.0"
LABEL "com.redhat.apb.spec"=\
"aWQ6IDU1YzUzYTVkLTY1YTYtNGMyNy04OGZjLWUwMjc0MTBiMTMzNwpuYW1lOiBtZWRpYXdpa2kx\
MjMtYXBiCmltYWdlOiBhbnNpYmxlcGxheWJvb2tidW5kbGUvbWVkaWF3aWtpMTIzLWFwYgpkZXNj\
cmlwdGlvbjogIm1lZGlhd2lraTEyMy1hcGIgZGVzY3JpcHRpb24iCmJpbmRhYmxlOiBmYWxzZQph\
c3luYzogb3B0aW9uYWwK"


ADD playbooks /opt/apb/actions
ADD roles /opt/ansible/roles

USER apb
