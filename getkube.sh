rm -r -f wip
rm -r -f src
mkdir src
mkdir wip
mkdir wip/bin
mkdir wip/bin/metadata
export VERSION=v1.11.3
export wcontent=${GOPATH}/src/github.com/glennswest/wcontent
rm $GOPATH/src/github.com/glennswest/wcontent/content/kube_$VERSION.ign
curl -L -k https://dl.k8s.io/$VERSION/kubernetes-node-windows-amd64.tar.gz -o /tmp/kubernetes.tar.gz
(cd src;tar xvzf /tmp/kubernetes.tar.gz )
cp src/kubernetes/node/bin/* wip/bin
(cd wip;$GOPATH/src/github.com/glennswest/libignition/igntool/igntool a ${wcontent}/content/kube_$VERSION.ign bin)
cp metadata/kube_$VERSION.metadata wip/bin/metadata/kube_$VERSION.metadata
(cd wip;$GOPATH/src/github.com/glennswest/libignition/igntool/igntool um ${wcontent}/content/kube_$VERSION.ign bin/metadata/kube_$VERSION.metadata)
(cd wip;$GOPATH/src/github.com/glennswest/libignition/igntool/igntool a ${wcontent}/content/kube_$VERSION.ign bin/metadata)
$GOPATH/src/github.com/glennswest/libignition/igntool/igntool ls ${wcontent}/content/kube_$VERSION.ign
cat wip/bin/metadata/kube_$VERSION.metadata
rm -r -f wip/*
rm -r -f src

