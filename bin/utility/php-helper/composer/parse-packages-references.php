<?php

$options = getopt('', ['file-path:', 'vendor-name:']);

if (empty($filePath = $options['file-path'])) {
    exit('DEFINE --file-path');
}

if (empty($vendorName = $options['vendor-name'])) {
    exit('DEFINE --vendor-name');
}

$composerLockFileContents = file_get_contents($filePath);
$composerLockParsed = json_decode($composerLockFileContents, true);
unset($composerLockFileContents);
$packages = $composerLockParsed['packages'] ?? [];
unset($composerLockParsed);

$vendorPackages = array_filter($packages, function($package) use ($vendorName) {
    return strpos($package['name'], $vendorName . '/') !== false;
});

$vendorPackagesReferences = [];
foreach ($vendorPackages as $vendorPackage) {
    $vendorPackagesReferences[$vendorPackage['name']] = $vendorPackage['source']['reference'];
}

unset($vendorPackages);
echo stripslashes(json_encode($vendorPackagesReferences));
