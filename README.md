# 日立×Intel AIハッカソン
- 概要
  - https://hackathon.we-are-ma.jp/aihackathon2021/
  - コンセプト: エッジAI

##  AIバーチャル試着【優秀賞】
　私のチームでは，AIによるバーチャル試着アプリケーションをiOS向けと店頭ディスプレイ向けに制作し，iOSの方が優秀賞を受賞した．私自身は後述するPF-AFNをエッジ上で推論できるように実装を担当した．

![demo](https://user-images.githubusercontent.com/33245796/124546437-9b177100-de65-11eb-8c34-3e0240310968.gif)


#### iOS
- https://github.com/natsuooo/ai-hackathon/tree/master/iOS


#### 店頭ディスプレイ
- https://github.com/natsuooo/ai-hackathon/tree/master/device

### AIアルゴリズム
- https://github.com/natsuooo/ai-hackathon/tree/master/notebooks
- CVPR2021論文「Parser-Free Virtual Try-on via Distilling Appearance Flows」を元にエッジ上で高速推論できるようにカスタマイズして実装した．
  - Paper: [Parser\-Free Virtual Try\-On via Distilling Appearance Flows](https://openaccess.thecvf.com/content/CVPR2021/papers/Ge_Parser-Free_Virtual_Try-On_via_Distilling_Appearance_Flows_CVPR_2021_paper.pdf)
  - Github: [geyuying/PF\-AFN: Official code for "Parser\-Free Virtual Try\-on via Distilling Appearance Flows", CVPR 2021\.](https://github.com/geyuying/PF-AFN)
  - 解説記事（自己執筆）: [バーチャル試着の実現はもう間近！？　生成モデル最前線！【PF\-AFN】 \| AI\-SCHOLAR \| AI：\(人工知能\)論文・技術情報メディア](https://ai-scholar.tech/articles/gan/pf-afn)