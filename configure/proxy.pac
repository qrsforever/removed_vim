function FindProxyForURL(url, host)
{
    if (isInNet(host, "10.0.0.0", "255.0.0.0")) {
        return "DIRECT";
    } else {
        if (shExpMatch(url, "http:*"))
            return "PROXY 123.125.89.214:80";
        if (shExpMatch(url, "https:*"))
            return "PROXY 123.125.89.214:80";
        // if (shExpMatch(url, "ftp:*"))
            // return "PROXY 123.125.89.214:23";
        return "DIRECT";
    }
}
