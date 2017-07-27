FROM ansibleplaybookbundle/apb-base

LABEL "com.redhat.apb.version"="0.1.0"
LABEL "com.redhat.apb.spec"=\
"aWQ6IDU1YzUzYTVkLTY1YTYtNGMyNy04OGZjLWUwMjc0MTBiMTg4MgpuYW1lOiBoZWxsby13b3Js\
ZC1hcGIKaW1hZ2U6IGFuc2libGVwbGF5Ym9va2J1bmRsZS9oZWxsby13b3JsZC1hcGIKZGVzY3Jp\
cHRpb246IGhlbGxvLXdvcmxkLWFwYiBkZXNjcmlwdGlvbgpiaW5kYWJsZTogRmFsc2UKYXN5bmM6\
IG9wdGlvbmFsCm1ldGFkYXRhOgogIGRpc3BsYXlOYW1lOiBIZWxsbyBXb3JsZAogIGRlcGVuZGVu\
Y2llczogWydkb2NrZXIuaW8vYW5zaWJsZXBsYXlib29rYnVuZGxlL2hlbGxvLXdvcmxkOmxhdGVz\
dCddCgpwYXJhbWV0ZXJzOiBbXQoKcmVxdWlyZWQ6IFtdCg=="

ADD playbooks /opt/apb/actions
ADD roles /opt/ansible/roles
RUN chown -R apb /opt/{ansible,apb} \
    && chmod -R g=u /opt/{ansible,apb}

USER apb
