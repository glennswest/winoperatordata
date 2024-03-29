rm -r -f wip
rm -r -f src
mkdir src
mkdir wip
mkdir wip/bin
mkdir wip/bin/metadata
mkdir wip/k
mkdir wip/k/logs
touch wip/k/logs/kubelet.log
export VERSION=v1.11.3
export COMPNAME=kube
export wcontent=${GOPATH}/src/github.com/glennswest/winoperatordata/wcontent
rm $GOPATH/src/github.com/glennswest/wcontent/content/${COMPNAME}_${VERSION}.ign
curl -L -k https://dl.k8s.io/${VERSION}/kubernetes-node-windows-amd64.tar.gz -o /tmp/kubernetes.tar.gz
(cd src;tar xvzf /tmp/kubernetes.tar.gz )
cp src/kubernetes/node/bin/* wip/bin
cp files/${COMPNAME}_${VERSION}/bin/* wip/bin
(cd wip;$GOPATH/src/github.com/glennswest/libignition/igntool/igntool a ${wcontent}/content/${COMPNAME}_$VERSION.ign bin)
(cd wip;$GOPATH/src/github.com/glennswest/libignition/igntool/igntool a ${wcontent}/content/${COMPNAME}_$VERSION.ign k)
cp metadata/${COMPNAME}_${VERSION}.metadata wip/bin/metadata/${COMPNAME}_${VERSION}.metadata
(cd wip;$GOPATH/src/github.com/glennswest/libignition/igntool/igntool um ${wcontent}/content/${COMPNAME}_${VERSION}.ign bin/metadata/${COMPNAME}_${VERSION}.metadata)
(cd wip;$GOPATH/src/github.com/glennswest/libignition/igntool/igntool a ${wcontent}/content/kube_${VERSION}.ign bin/metadata)
$GOPATH/src/github.com/glennswest/libignition/igntool/igntool ls ${wcontent}/content/${COMPNAME}_${VERSION}.ign
cat wip/bin/metadata/${COMPNAME}_${VERSION}.metadata
./mvtocontainer.sh
