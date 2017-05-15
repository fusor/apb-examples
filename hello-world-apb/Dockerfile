FROM ansibleplaybookbundle/apb-base

LABEL "com.redhat.apb.version"="0.1.0"
LABEL "com.redhat.apb.spec"=\
"aWQ6IDU1YzUzYTVkLTY1YTYtNGMyNy04OGZjLWUwMjc0MTBiMTg4MgpuYW1lOiBoZWxsby13b3Js\
ZC1hcGIKaW1hZ2U6IGFuc2libGVwbGF5Ym9va2J1bmRsZS9oZWxsby13b3JsZC1hcGIKZGVzY3Jp\
cHRpb246ICJoZWxsby13b3JsZC1hcGIgZGVzY3JpcHRpb24iCmJpbmRhYmxlOiBmYWxzZQphc3lu\
Yzogb3B0aW9uYWwK"


ADD playbooks /opt/apb/actions
ADD roles /opt/ansible/roles

USER apb
