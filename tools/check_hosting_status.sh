#!/bin/bash

domain="$1"
config_file="$HOME/GhostCheck/config/hosting_patterns.conf"

[[ -z "$domain" ]] && {
    echo "❌ Usage: $0 domain.com"
    exit 1
}

if [[ ! -f "$config_file" ]]; then
    echo "⚠️  No hosting patterns found at $config_file"
    echo "➡️  Create this file with one pattern per line (e.g., neonova.net, nrtc.net)"
    exit 2
fi

mapfile -t our_ns_patterns < "$config_file"

echo -e "\n[== Hosting Status Check for: $domain ==]"

soa=$(dig "$domain" SOA +short | awk '{print $1}')
ns=$(dig "$domain" NS +short | paste -sd "," -)

hosted=false
match=""
for pattern in "${our_ns_patterns[@]}"; do
    if [[ "$soa" == *"$pattern"* || "$ns" == *"$pattern"* ]]; then
        hosted=true
        match="$pattern"
        break
    fi
done

echo -e "\n[== SOA Record ==]\n$soa"
echo -e "\n[== NS Records ==]\n$ns"
echo -e "\n[== Hosting Status ==]"

if $hosted; then
    echo "✅ Domain *is* hosted (matched: $match)"
else
    echo "❌ Domain is *NOT* hosted by any known provider in your config"
fi
