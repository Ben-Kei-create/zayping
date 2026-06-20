import Foundation

struct TriviaBank {
    static let items: [TriviaItem] = [
        // 動物 - Animals
        TriviaItem(category: .animals, displayText: "タコのこころは三つある",
                   explanation: "タコは全身に血液を送るため、メインの心臓1つとエラ心臓2つの合計3つの心臓を持っています。", difficulty: .easy),
        TriviaItem(category: .animals, displayText: "カタツムリのはは約二万本",
                   explanation: "カタツムリの歯舌（しぜつ）には約2万本もの微小な歯が並んでいます。", difficulty: .easy),
        TriviaItem(category: .animals, displayText: "キリンのすいみんは一日二十分",
                   explanation: "キリンは外敵から身を守るため、1日にわずか約20分しか眠りません。", difficulty: .easy),
        TriviaItem(category: .animals, displayText: "イルカはかたほうのめをあけてねる",
                   explanation: "イルカは脳の半分ずつ交互に眠る「半球睡眠」を行い、片目を開けたまま泳ぎ続けます。", difficulty: .normal),
        TriviaItem(category: .animals, displayText: "ラッコはねるときてをつないでねる",
                   explanation: "ラッコは海流に流されないよう、寝るときに仲間と手をつなぐ習性があります。", difficulty: .normal),
        TriviaItem(category: .animals, displayText: "フラミンゴがピンクなのはえさのせい",
                   explanation: "フラミンゴは生まれたときは白色で、エビなどに含まれるカロテノイドによってピンクに染まります。", difficulty: .normal),
        TriviaItem(category: .animals, displayText: "ゴリラはあいさつでおなかをたたく",
                   explanation: "ゴリラが胸を叩くドラミングは威嚇だけでなく、挨拶や自己紹介の意味もあります。", difficulty: .normal),
        TriviaItem(category: .animals, displayText: "ハチドリはうしろむきにとべるゆいつのとり",
                   explanation: "ハチドリは翼を8の字に動かすことで、後ろ向きや横向き、ホバリングも自在にできます。", difficulty: .hard),
        TriviaItem(category: .animals, displayText: "カメレオンのしたのながさはたいちょうのにばい",
                   explanation: "カメレオンの舌は体長の約2倍あり、0.07秒で獲物を捕らえることができます。", difficulty: .hard),
        TriviaItem(category: .animals, displayText: "ミツバチはかずのがいねんをりかいできる",
                   explanation: "研究により、ミツバチはゼロの概念を含む数の大小を理解できることが判明しました。", difficulty: .hard),

        // 科学 - Science
        TriviaItem(category: .science, displayText: "かみなりはたいようよりあつい",
                   explanation: "雷の温度は約3万度で、太陽の表面温度（約6千度）の5倍にもなります。", difficulty: .easy),
        TriviaItem(category: .science, displayText: "ダイヤモンドはもやせる",
                   explanation: "ダイヤモンドは炭素でできているため、約800度以上で燃えてCO2になります。", difficulty: .easy),
        TriviaItem(category: .science, displayText: "おゆよりみずのほうがはやくこおる",
                   explanation: "ムペンバ効果と呼ばれ、条件次第でお湯が冷水より早く凍ることがあります。", difficulty: .normal),
        TriviaItem(category: .science, displayText: "にんげんのディーエヌエーはバナナとはんぶんおなじ",
                   explanation: "人間とバナナのDNAは約50%が共通しています。生命の基本設計は共通部分が多いのです。", difficulty: .normal),
        TriviaItem(category: .science, displayText: "いっしょうでちきゅうをにしゅうぶんあるく",
                   explanation: "人間は一生で平均約10万km歩き、これは地球を約2.5周する距離に相当します。", difficulty: .hard),
        TriviaItem(category: .science, displayText: "ガラスはえきたいでもこたいでもないふしぎなぶっしつ",
                   explanation: "ガラスは「アモルファス固体」と呼ばれ、結晶構造を持たない特殊な状態にあります。", difficulty: .hard),

        // 歴史 - History
        TriviaItem(category: .history, displayText: "クレオパトラはピラミッドよりスマホにちかい",
                   explanation: "クレオパトラ（紀元前69年）はピラミッド建設（紀元前2560年）より、スマホの時代に近い時代を生きました。", difficulty: .normal),
        TriviaItem(category: .history, displayText: "にほんさいこのカレーにはかえるがはいっていた",
                   explanation: "明治時代の日本初のカレーレシピには、具材としてカエルが記載されていました。", difficulty: .normal),
        TriviaItem(category: .history, displayText: "オックスフォードだいがくはアステカぶんめいよりふるい",
                   explanation: "オックスフォード大学（1096年）は、アステカ文明の首都テノチティトラン建設（1325年）より古いのです。", difficulty: .hard),
        TriviaItem(category: .history, displayText: "ナポレオンはじつはせがひくくなかった",
                   explanation: "ナポレオンの身長は約170cmで、当時のフランス人男性の平均身長とほぼ同じでした。", difficulty: .easy),
        TriviaItem(category: .history, displayText: "サメはきょうりゅうよりもふるいいきもの",
                   explanation: "サメは約4億年前から存在し、恐竜（約2.3億年前）よりもはるかに古い生き物です。", difficulty: .normal),

        // 食べ物 - Food
        TriviaItem(category: .food, displayText: "ハチミツはなんねんたってもくさらない",
                   explanation: "はちみつは水分が少なく酸性度が高いため、3000年前のものでも食べられる状態で発見されています。", difficulty: .easy),
        TriviaItem(category: .food, displayText: "イチゴのつぶつぶはじつはたね",
                   explanation: "イチゴの表面のつぶつぶ一つ一つが実は果実で、赤い部分は花托（かたく）です。", difficulty: .easy),
        TriviaItem(category: .food, displayText: "チョコレートはむかしおかねだった",
                   explanation: "古代アステカではカカオ豆が通貨として使用され、奴隷1人がカカオ100粒で取引されていました。", difficulty: .normal),
        TriviaItem(category: .food, displayText: "ポテトチップスはきゃくのくじょうからうまれた",
                   explanation: "1853年、「ポテトが厚すぎる」と文句を言った客への当てつけで薄く揚げたのが始まりです。", difficulty: .normal),
        TriviaItem(category: .food, displayText: "キュウリのきゅうじゅうごパーセントはみず",
                   explanation: "きゅうりの95%以上は水分で、野菜の中で最も水分含有量が高い食べ物の一つです。", difficulty: .easy),
        TriviaItem(category: .food, displayText: "わさびのからさはじゅうごふんでほぼきえる",
                   explanation: "わさびの辛味成分アリルイソチオシアネートは揮発性が高く、すりおろして約15分で大部分が消えます。", difficulty: .hard),

        // 人体 - Human Body
        TriviaItem(category: .body, displayText: "にんげんのはなはいっちょうのにおいをかぎわけられる",
                   explanation: "人間の嗅覚受容体は約400種類あり、組み合わせで1兆以上の匂いを識別できます。", difficulty: .normal),
        TriviaItem(category: .body, displayText: "あかちゃんのほねはおとなよりおおい",
                   explanation: "赤ちゃんは約300個の骨を持ち、成長とともに癒合して大人では206個になります。", difficulty: .easy),
        TriviaItem(category: .body, displayText: "いのなかのさんはてつもとかす",
                   explanation: "胃酸（塩酸）のpHは1〜2で非常に強力。金属を溶かすほどの強さがあります。", difficulty: .easy),
        TriviaItem(category: .body, displayText: "くしゃみのそくどはしそくさんびゃくキロ",
                   explanation: "くしゃみの速度は時速約300kmに達し、新幹線とほぼ同じ速さです。", difficulty: .normal),
        TriviaItem(category: .body, displayText: "のうはからだのエネルギーのにじゅうパーセントをつかう",
                   explanation: "脳の重さは体重の約2%ですが、体全体のエネルギーの20%を消費しています。", difficulty: .hard),

        // 宇宙 - Space
        TriviaItem(category: .space, displayText: "うちゅうはかんぜんなむおんのせかい",
                   explanation: "宇宙は真空のため音を伝える媒質がなく、完全な無音の世界です。", difficulty: .easy),
        TriviaItem(category: .space, displayText: "いちにちはにじゅうよじかんではない",
                   explanation: "地球の自転周期は正確には23時間56分4秒で、24時間ちょうどではありません。", difficulty: .easy),
        TriviaItem(category: .space, displayText: "きんせいのいちにちはいちねんよりながい",
                   explanation: "金星の自転周期（243日）は公転周期（225日）より長いため、1日が1年より長いのです。", difficulty: .normal),
        TriviaItem(category: .space, displayText: "スプーンいっぱいのちゅうせいしせいはおもさろくじゅうおくトン",
                   explanation: "中性子星の密度は極めて高く、スプーン1杯分で約60億トンにもなります。", difficulty: .hard),
        TriviaItem(category: .space, displayText: "うちゅうにはちきゅうのすなつぶよりおおいほしがある",
                   explanation: "観測可能な宇宙には約2兆個の銀河があり、星の数は地球上の砂粒より多いとされています。", difficulty: .normal),

        // 言葉 - Language
        TriviaItem(category: .language, displayText: "にほんごのいろのなまえはよんひゃくいじょうある",
                   explanation: "日本の伝統色は450以上あり、「鴇色」「空五倍子色」など独特な名前がついています。", difficulty: .normal),
        TriviaItem(category: .language, displayText: "オーケーはせかいでいちばんつうじることば",
                   explanation: "「OK」は世界中のほぼすべての言語で理解される、最も普遍的な言葉です。", difficulty: .easy),
        TriviaItem(category: .language, displayText: "かんじのなかでいちばんかくすうがおおいのはたいと",
                   explanation: "最も画数が多い漢字「たいと」は84画あり、雲が3つと龍が3つで構成されています。", difficulty: .hard),

        // 雑学 - Random
        TriviaItem(category: .random, displayText: "じゃんけんはにほんはっしょう",
                   explanation: "じゃんけんは江戸時代の日本で生まれ、世界中に広まった遊びです。", difficulty: .easy),
        TriviaItem(category: .random, displayText: "しんごうきのあおはじつはみどりいろ",
                   explanation: "日本の信号機の「青」は実際には緑色ですが、日本語で緑を「青」と呼ぶ文化的慣習が理由です。", difficulty: .easy),
        TriviaItem(category: .random, displayText: "トランプのキングにはモデルがいる",
                   explanation: "スペードはダビデ王、ハートはカール大帝、ダイヤはカエサル、クラブはアレキサンダー大王がモデルです。", difficulty: .normal),
        TriviaItem(category: .random, displayText: "にほんにはじどうはんばいきがごひゃくまんだいある",
                   explanation: "日本の自動販売機は約500万台で、世界一の密度を誇ります。約23人に1台の計算です。", difficulty: .normal),
        TriviaItem(category: .random, displayText: "いちえんだまはみずにうく",
                   explanation: "1円玉はアルミニウム製で重さ1g。表面張力によって水に浮かべることができます。", difficulty: .easy),
        TriviaItem(category: .random, displayText: "せかいでいちばんみじかいせんそうはよんじゅっぷん",
                   explanation: "1896年のイギリスとザンジバルの戦争は、わずか38〜45分で終結しました。", difficulty: .hard),
        TriviaItem(category: .random, displayText: "にんげんとキリンのくびのほねのかずはおなじ",
                   explanation: "人間もキリンも頸椎は7個。キリンは1個の骨が非常に長いだけなのです。", difficulty: .normal),
        TriviaItem(category: .random, displayText: "エベレストのてっぺんにはかいのかせきがある",
                   explanation: "エベレスト山頂の岩には海洋生物の化石があり、かつて海底だったことを示しています。", difficulty: .hard),
    ]

    static func items(for category: TriviaCategory?, difficulty: Difficulty?) -> [TriviaItem] {
        var filtered = items
        if let category = category {
            filtered = filtered.filter { $0.category == category }
        }
        if let difficulty = difficulty {
            filtered = filtered.filter { $0.difficulty == difficulty }
        }
        return filtered.shuffled()
    }

    static func randomItems(count: Int, difficulty: Difficulty) -> [TriviaItem] {
        let pool = items.filter { $0.difficulty == difficulty || (difficulty == .normal) }
        return Array(pool.shuffled().prefix(count))
    }
}
