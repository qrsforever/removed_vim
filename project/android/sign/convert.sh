rm platform.priv.pem platform.pk12 platform.keystore 2>/dev/null

openssl pkcs8 -in platform.pk8 -inform DER -outform PEM -out platform.priv.pem -nocrypt

# PKCS12密码:654321
openssl pkcs12 -export -in platform.x509.pem -inkey platform.priv.pem -out platform.pk12 -name iptv << EOF
654321
654321
EOF

# PKCS12 store密码和key密码是相同的, eg:654321
keytool -importkeystore -srcstoretype PKCS12\
    -destkeystore platform.keystore -deststorepass 123456 -destkeypass 123456 -destalias platform \
     -srckeystore platform.pk12  -srcstorepass 654321  -srckeypass 654321 -srcalias iptv 

# openssl pkcs12 -h

rm shared.priv.pem shared.pk12 shared.keystore 2>/dev/null

openssl pkcs8 -in shared.pk8 -inform DER -outform PEM -out shared.priv.pem -nocrypt

# PKCS12密码:654321
openssl pkcs12 -export -in shared.x509.pem -inkey shared.priv.pem -out shared.pk12 -name iptv << EOF
654321
654321
EOF

# PKCS12 store密码和key密码是相同的, eg:654321
keytool -importkeystore -srcstoretype PKCS12\
    -destkeystore shared.keystore -deststorepass 123456 -destkeypass 123456 -destalias shared \
     -srckeystore shared.pk12  -srcstorepass 654321  -srckeypass 654321 -srcalias iptv 
