# Subclassに課される要件を文書かするテスト
# post_initializeやlocal_sparesはサブクラスの自由
# あくまでメッセージを壊すような実装をしたいないかを確かめる
# default_tire_size は親クラスでNotImplementation Errorが起きる
module BicycleSubclassTest
  def test_responds_to_post_initialize
    assert_respond_to(@object, :post_initialize)
  end

  def test_responds_to_local_spares
    assert_respond_to(@object, :local_spares)
  end

  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end
end
