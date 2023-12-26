

import '../models/province/province.dart';

Map<String, VNDistrict> vnDistricts = {
  "D_1": VNDistrict(
      "Quận Ba Đình", 1, VietnamDivisionType.QUAN, "quan_ba_dinh", 1),
  "D_2": VNDistrict(
      "Quận Hoàn Kiếm", 2, VietnamDivisionType.QUAN, "quan_hoan_kiem", 1),
  "D_3":
      VNDistrict("Quận Tây Hồ", 3, VietnamDivisionType.QUAN, "quan_tay_ho", 1),
  "D_4": VNDistrict(
      "Quận Long Biên", 4, VietnamDivisionType.QUAN, "quan_long_bien", 1),
  "D_5": VNDistrict(
      "Quận Cầu Giấy", 5, VietnamDivisionType.QUAN, "quan_cau_giay", 1),
  "D_6": VNDistrict(
      "Quận Đống Đa", 6, VietnamDivisionType.QUAN, "quan_dong_da", 1),
  "D_7": VNDistrict(
      "Quận Hai Bà Trưng", 7, VietnamDivisionType.QUAN, "quan_hai_ba_trung", 1),
  "D_8": VNDistrict(
      "Quận Hoàng Mai", 8, VietnamDivisionType.QUAN, "quan_hoang_mai", 1),
  "D_9": VNDistrict(
      "Quận Thanh Xuân", 9, VietnamDivisionType.QUAN, "quan_thanh_xuan", 1),
  "D_16": VNDistrict(
      "Huyện Sóc Sơn", 16, VietnamDivisionType.HUYEN, "huyen_soc_son", 1),
  "D_17": VNDistrict(
      "Huyện Đông Anh", 17, VietnamDivisionType.HUYEN, "huyen_dong_anh", 1),
  "D_18": VNDistrict(
      "Huyện Gia Lâm", 18, VietnamDivisionType.HUYEN, "huyen_gia_lam", 1),
  "D_19": VNDistrict(
      "Quận Nam Từ Liêm", 19, VietnamDivisionType.QUAN, "quan_nam_tu_liem", 1),
  "D_20": VNDistrict(
      "Huyện Thanh Trì", 20, VietnamDivisionType.HUYEN, "huyen_thanh_tri", 1),
  "D_21": VNDistrict(
      "Quận Bắc Từ Liêm", 21, VietnamDivisionType.QUAN, "quan_bac_tu_liem", 1),
  "D_250": VNDistrict(
      "Huyện Mê Linh", 250, VietnamDivisionType.HUYEN, "huyen_me_linh", 1),
  "D_268": VNDistrict(
      "Quận Hà Đông", 268, VietnamDivisionType.QUAN, "quan_ha_dong", 1),
  "D_269": VNDistrict(
      "Thị xã Sơn Tây", 269, VietnamDivisionType.THI_XA, "thi_xa_son_tay", 1),
  "D_271": VNDistrict(
      "Huyện Ba Vì", 271, VietnamDivisionType.HUYEN, "huyen_ba_vi", 1),
  "D_272": VNDistrict(
      "Huyện Phúc Thọ", 272, VietnamDivisionType.HUYEN, "huyen_phuc_tho", 1),
  "D_273": VNDistrict("Huyện Đan Phượng", 273, VietnamDivisionType.HUYEN,
      "huyen_dan_phuong", 1),
  "D_274": VNDistrict(
      "Huyện Hoài Đức", 274, VietnamDivisionType.HUYEN, "huyen_hoai_duc", 1),
  "D_275": VNDistrict(
      "Huyện Quốc Oai", 275, VietnamDivisionType.HUYEN, "huyen_quoc_oai", 1),
  "D_276": VNDistrict("Huyện Thạch Thất", 276, VietnamDivisionType.HUYEN,
      "huyen_thach_that", 1),
  "D_277": VNDistrict(
      "Huyện Chương Mỹ", 277, VietnamDivisionType.HUYEN, "huyen_chuong_my", 1),
  "D_278": VNDistrict(
      "Huyện Thanh Oai", 278, VietnamDivisionType.HUYEN, "huyen_thanh_oai", 1),
  "D_279": VNDistrict("Huyện Thường Tín", 279, VietnamDivisionType.HUYEN,
      "huyen_thuong_tin", 1),
  "D_280": VNDistrict(
      "Huyện Phú Xuyên", 280, VietnamDivisionType.HUYEN, "huyen_phu_xuyen", 1),
  "D_281": VNDistrict(
      "Huyện Ứng Hòa", 281, VietnamDivisionType.HUYEN, "huyen_ung_hoa", 1),
  "D_282": VNDistrict(
      "Huyện Mỹ Đức", 282, VietnamDivisionType.HUYEN, "huyen_my_duc", 1),
  "D_24": VNDistrict("Thành phố Hà Giang", 24, VietnamDivisionType.THANH_PHO,
      "thanh_pho_ha_giang", 2),
  "D_26": VNDistrict(
      "Huyện Đồng Văn", 26, VietnamDivisionType.HUYEN, "huyen_dong_van", 2),
  "D_27": VNDistrict(
      "Huyện Mèo Vạc", 27, VietnamDivisionType.HUYEN, "huyen_meo_vac", 2),
  "D_28": VNDistrict(
      "Huyện Yên Minh", 28, VietnamDivisionType.HUYEN, "huyen_yen_minh", 2),
  "D_29": VNDistrict(
      "Huyện Quản Bạ", 29, VietnamDivisionType.HUYEN, "huyen_quan_ba", 2),
  "D_30": VNDistrict(
      "Huyện Vị Xuyên", 30, VietnamDivisionType.HUYEN, "huyen_vi_xuyen", 2),
  "D_31": VNDistrict(
      "Huyện Bắc Mê", 31, VietnamDivisionType.HUYEN, "huyen_bac_me", 2),
  "D_32": VNDistrict("Huyện Hoàng Su Phì", 32, VietnamDivisionType.HUYEN,
      "huyen_hoang_su_phi", 2),
  "D_33": VNDistrict(
      "Huyện Xín Mần", 33, VietnamDivisionType.HUYEN, "huyen_xin_man", 2),
  "D_34": VNDistrict(
      "Huyện Bắc Quang", 34, VietnamDivisionType.HUYEN, "huyen_bac_quang", 2),
  "D_35": VNDistrict(
      "Huyện Quang Bình", 35, VietnamDivisionType.HUYEN, "huyen_quang_binh", 2),
  "D_40": VNDistrict("Thành phố Cao Bằng", 40, VietnamDivisionType.THANH_PHO,
      "thanh_pho_cao_bang", 4),
  "D_42": VNDistrict(
      "Huyện Bảo Lâm", 42, VietnamDivisionType.HUYEN, "huyen_bao_lam", 4),
  "D_43": VNDistrict(
      "Huyện Bảo Lạc", 43, VietnamDivisionType.HUYEN, "huyen_bao_lac", 4),
  "D_45": VNDistrict(
      "Huyện Hà Quảng", 45, VietnamDivisionType.HUYEN, "huyen_ha_quang", 4),
  "D_47": VNDistrict("Huyện Trùng Khánh", 47, VietnamDivisionType.HUYEN,
      "huyen_trung_khanh", 4),
  "D_48": VNDistrict(
      "Huyện Hạ Lang", 48, VietnamDivisionType.HUYEN, "huyen_ha_lang", 4),
  "D_49": VNDistrict(
      "Huyện Quảng Hòa", 49, VietnamDivisionType.HUYEN, "huyen_quang_hoa", 4),
  "D_51": VNDistrict(
      "Huyện Hoà An", 51, VietnamDivisionType.HUYEN, "huyen_hoa_an", 4),
  "D_52": VNDistrict("Huyện Nguyên Bình", 52, VietnamDivisionType.HUYEN,
      "huyen_nguyen_binh", 4),
  "D_53": VNDistrict(
      "Huyện Thạch An", 53, VietnamDivisionType.HUYEN, "huyen_thach_an", 4),
  "D_58": VNDistrict("Thành Phố Bắc Kạn", 58, VietnamDivisionType.THANH_PHO,
      "thanh_pho_bac_kan", 6),
  "D_60": VNDistrict(
      "Huyện Pác Nặm", 60, VietnamDivisionType.HUYEN, "huyen_pac_nam", 6),
  "D_61": VNDistrict(
      "Huyện Ba Bể", 61, VietnamDivisionType.HUYEN, "huyen_ba_be", 6),
  "D_62": VNDistrict(
      "Huyện Ngân Sơn", 62, VietnamDivisionType.HUYEN, "huyen_ngan_son", 6),
  "D_63": VNDistrict(
      "Huyện Bạch Thông", 63, VietnamDivisionType.HUYEN, "huyen_bach_thong", 6),
  "D_64": VNDistrict(
      "Huyện Chợ Đồn", 64, VietnamDivisionType.HUYEN, "huyen_cho_don", 6),
  "D_65": VNDistrict(
      "Huyện Chợ Mới", 65, VietnamDivisionType.HUYEN, "huyen_cho_moi", 6),
  "D_66": VNDistrict(
      "Huyện Na Rì", 66, VietnamDivisionType.HUYEN, "huyen_na_ri", 6),
  "D_70": VNDistrict("Thành phố Tuyên Quang", 70, VietnamDivisionType.THANH_PHO,
      "thanh_pho_tuyen_quang", 8),
  "D_71": VNDistrict(
      "Huyện Lâm Bình", 71, VietnamDivisionType.HUYEN, "huyen_lam_binh", 8),
  "D_72": VNDistrict(
      "Huyện Na Hang", 72, VietnamDivisionType.HUYEN, "huyen_na_hang", 8),
  "D_73": VNDistrict(
      "Huyện Chiêm Hóa", 73, VietnamDivisionType.HUYEN, "huyen_chiem_hoa", 8),
  "D_74": VNDistrict(
      "Huyện Hàm Yên", 74, VietnamDivisionType.HUYEN, "huyen_ham_yen", 8),
  "D_75": VNDistrict(
      "Huyện Yên Sơn", 75, VietnamDivisionType.HUYEN, "huyen_yen_son", 8),
  "D_76": VNDistrict(
      "Huyện Sơn Dương", 76, VietnamDivisionType.HUYEN, "huyen_son_duong", 8),
  "D_80": VNDistrict("Thành phố Lào Cai", 80, VietnamDivisionType.THANH_PHO,
      "thanh_pho_lao_cai", 10),
  "D_82": VNDistrict(
      "Huyện Bát Xát", 82, VietnamDivisionType.HUYEN, "huyen_bat_xat", 10),
  "D_83": VNDistrict("Huyện Mường Khương", 83, VietnamDivisionType.HUYEN,
      "huyen_muong_khuong", 10),
  "D_84": VNDistrict(
      "Huyện Si Ma Cai", 84, VietnamDivisionType.HUYEN, "huyen_si_ma_cai", 10),
  "D_85": VNDistrict(
      "Huyện Bắc Hà", 85, VietnamDivisionType.HUYEN, "huyen_bac_ha", 10),
  "D_86": VNDistrict(
      "Huyện Bảo Thắng", 86, VietnamDivisionType.HUYEN, "huyen_bao_thang", 10),
  "D_87": VNDistrict(
      "Huyện Bảo Yên", 87, VietnamDivisionType.HUYEN, "huyen_bao_yen", 10),
  "D_88": VNDistrict(
      "Thị xã Sa Pa", 88, VietnamDivisionType.THI_XA, "thi_xa_sa_pa", 10),
  "D_89": VNDistrict(
      "Huyện Văn Bàn", 89, VietnamDivisionType.HUYEN, "huyen_van_ban", 10),
  "D_94": VNDistrict("Thành phố Điện Biên Phủ", 94,
      VietnamDivisionType.THANH_PHO, "thanh_pho_dien_bien_phu", 11),
  "D_95": VNDistrict("Thị xã Mường Lay", 95, VietnamDivisionType.THI_XA,
      "thi_xa_muong_lay", 11),
  "D_96": VNDistrict(
      "Huyện Mường Nhé", 96, VietnamDivisionType.HUYEN, "huyen_muong_nhe", 11),
  "D_97": VNDistrict(
      "Huyện Mường Chà", 97, VietnamDivisionType.HUYEN, "huyen_muong_cha", 11),
  "D_98": VNDistrict(
      "Huyện Tủa Chùa", 98, VietnamDivisionType.HUYEN, "huyen_tua_chua", 11),
  "D_99": VNDistrict(
      "Huyện Tuần Giáo", 99, VietnamDivisionType.HUYEN, "huyen_tuan_giao", 11),
  "D_100": VNDistrict(
      "Huyện Điện Biên", 100, VietnamDivisionType.HUYEN, "huyen_dien_bien", 11),
  "D_101": VNDistrict("Huyện Điện Biên Đông", 101, VietnamDivisionType.HUYEN,
      "huyen_dien_bien_dong", 11),
  "D_102": VNDistrict(
      "Huyện Mường Ảng", 102, VietnamDivisionType.HUYEN, "huyen_muong_ang", 11),
  "D_103": VNDistrict(
      "Huyện Nậm Pồ", 103, VietnamDivisionType.HUYEN, "huyen_nam_po", 11),
  "D_105": VNDistrict("Thành phố Lai Châu", 105, VietnamDivisionType.THANH_PHO,
      "thanh_pho_lai_chau", 12),
  "D_106": VNDistrict(
      "Huyện Tam Đường", 106, VietnamDivisionType.HUYEN, "huyen_tam_duong", 12),
  "D_107": VNDistrict(
      "Huyện Mường Tè", 107, VietnamDivisionType.HUYEN, "huyen_muong_te", 12),
  "D_108": VNDistrict(
      "Huyện Sìn Hồ", 108, VietnamDivisionType.HUYEN, "huyen_sin_ho", 12),
  "D_109": VNDistrict(
      "Huyện Phong Thổ", 109, VietnamDivisionType.HUYEN, "huyen_phong_tho", 12),
  "D_110": VNDistrict(
      "Huyện Than Uyên", 110, VietnamDivisionType.HUYEN, "huyen_than_uyen", 12),
  "D_111": VNDistrict(
      "Huyện Tân Uyên", 111, VietnamDivisionType.HUYEN, "huyen_tan_uyen", 12),
  "D_112": VNDistrict(
      "Huyện Nậm Nhùn", 112, VietnamDivisionType.HUYEN, "huyen_nam_nhun", 12),
  "D_116": VNDistrict("Thành phố Sơn La", 116, VietnamDivisionType.THANH_PHO,
      "thanh_pho_son_la", 14),
  "D_118": VNDistrict("Huyện Quỳnh Nhai", 118, VietnamDivisionType.HUYEN,
      "huyen_quynh_nhai", 14),
  "D_119": VNDistrict("Huyện Thuận Châu", 119, VietnamDivisionType.HUYEN,
      "huyen_thuan_chau", 14),
  "D_120": VNDistrict(
      "Huyện Mường La", 120, VietnamDivisionType.HUYEN, "huyen_muong_la", 14),
  "D_121": VNDistrict(
      "Huyện Bắc Yên", 121, VietnamDivisionType.HUYEN, "huyen_bac_yen", 14),
  "D_122": VNDistrict(
      "Huyện Phù Yên", 122, VietnamDivisionType.HUYEN, "huyen_phu_yen", 14),
  "D_123": VNDistrict(
      "Huyện Mộc Châu", 123, VietnamDivisionType.HUYEN, "huyen_moc_chau", 14),
  "D_124": VNDistrict(
      "Huyện Yên Châu", 124, VietnamDivisionType.HUYEN, "huyen_yen_chau", 14),
  "D_125": VNDistrict(
      "Huyện Mai Sơn", 125, VietnamDivisionType.HUYEN, "huyen_mai_son", 14),
  "D_126": VNDistrict(
      "Huyện Sông Mã", 126, VietnamDivisionType.HUYEN, "huyen_song_ma", 14),
  "D_127": VNDistrict(
      "Huyện Sốp Cộp", 127, VietnamDivisionType.HUYEN, "huyen_sop_cop", 14),
  "D_128": VNDistrict(
      "Huyện Vân Hồ", 128, VietnamDivisionType.HUYEN, "huyen_van_ho", 14),
  "D_132": VNDistrict("Thành phố Yên Bái", 132, VietnamDivisionType.THANH_PHO,
      "thanh_pho_yen_bai", 15),
  "D_133": VNDistrict("Thị xã Nghĩa Lộ", 133, VietnamDivisionType.THI_XA,
      "thi_xa_nghia_lo", 15),
  "D_135": VNDistrict(
      "Huyện Lục Yên", 135, VietnamDivisionType.HUYEN, "huyen_luc_yen", 15),
  "D_136": VNDistrict(
      "Huyện Văn Yên", 136, VietnamDivisionType.HUYEN, "huyen_van_yen", 15),
  "D_137": VNDistrict("Huyện Mù Căng Chải", 137, VietnamDivisionType.HUYEN,
      "huyen_mu_cang_chai", 15),
  "D_138": VNDistrict(
      "Huyện Trấn Yên", 138, VietnamDivisionType.HUYEN, "huyen_tran_yen", 15),
  "D_139": VNDistrict(
      "Huyện Trạm Tấu", 139, VietnamDivisionType.HUYEN, "huyen_tram_tau", 15),
  "D_140": VNDistrict(
      "Huyện Văn Chấn", 140, VietnamDivisionType.HUYEN, "huyen_van_chan", 15),
  "D_141": VNDistrict(
      "Huyện Yên Bình", 141, VietnamDivisionType.HUYEN, "huyen_yen_binh", 15),
  "D_148": VNDistrict("Thành phố Hòa Bình", 148, VietnamDivisionType.THANH_PHO,
      "thanh_pho_hoa_binh", 17),
  "D_150": VNDistrict(
      "Huyện Đà Bắc", 150, VietnamDivisionType.HUYEN, "huyen_da_bac", 17),
  "D_152": VNDistrict(
      "Huyện Lương Sơn", 152, VietnamDivisionType.HUYEN, "huyen_luong_son", 17),
  "D_153": VNDistrict(
      "Huyện Kim Bôi", 153, VietnamDivisionType.HUYEN, "huyen_kim_boi", 17),
  "D_154": VNDistrict(
      "Huyện Cao Phong", 154, VietnamDivisionType.HUYEN, "huyen_cao_phong", 17),
  "D_155": VNDistrict(
      "Huyện Tân Lạc", 155, VietnamDivisionType.HUYEN, "huyen_tan_lac", 17),
  "D_156": VNDistrict(
      "Huyện Mai Châu", 156, VietnamDivisionType.HUYEN, "huyen_mai_chau", 17),
  "D_157": VNDistrict(
      "Huyện Lạc Sơn", 157, VietnamDivisionType.HUYEN, "huyen_lac_son", 17),
  "D_158": VNDistrict(
      "Huyện Yên Thủy", 158, VietnamDivisionType.HUYEN, "huyen_yen_thuy", 17),
  "D_159": VNDistrict(
      "Huyện Lạc Thủy", 159, VietnamDivisionType.HUYEN, "huyen_lac_thuy", 17),
  "D_164": VNDistrict("Thành phố Thái Nguyên", 164,
      VietnamDivisionType.THANH_PHO, "thanh_pho_thai_nguyen", 19),
  "D_165": VNDistrict("Thành phố Sông Công", 165, VietnamDivisionType.THANH_PHO,
      "thanh_pho_song_cong", 19),
  "D_167": VNDistrict(
      "Huyện Định Hóa", 167, VietnamDivisionType.HUYEN, "huyen_dinh_hoa", 19),
  "D_168": VNDistrict(
      "Huyện Phú Lương", 168, VietnamDivisionType.HUYEN, "huyen_phu_luong", 19),
  "D_169": VNDistrict(
      "Huyện Đồng Hỷ", 169, VietnamDivisionType.HUYEN, "huyen_dong_hy", 19),
  "D_170": VNDistrict(
      "Huyện Võ Nhai", 170, VietnamDivisionType.HUYEN, "huyen_vo_nhai", 19),
  "D_171": VNDistrict(
      "Huyện Đại Từ", 171, VietnamDivisionType.HUYEN, "huyen_dai_tu", 19),
  "D_172": VNDistrict(
      "Thị xã Phổ Yên", 172, VietnamDivisionType.THI_XA, "thi_xa_pho_yen", 19),
  "D_173": VNDistrict(
      "Huyện Phú Bình", 173, VietnamDivisionType.HUYEN, "huyen_phu_binh", 19),
  "D_178": VNDistrict("Thành phố Lạng Sơn", 178, VietnamDivisionType.THANH_PHO,
      "thanh_pho_lang_son", 20),
  "D_180": VNDistrict("Huyện Tràng Định", 180, VietnamDivisionType.HUYEN,
      "huyen_trang_dinh", 20),
  "D_181": VNDistrict(
      "Huyện Bình Gia", 181, VietnamDivisionType.HUYEN, "huyen_binh_gia", 20),
  "D_182": VNDistrict(
      "Huyện Văn Lãng", 182, VietnamDivisionType.HUYEN, "huyen_van_lang", 20),
  "D_183": VNDistrict(
      "Huyện Cao Lộc", 183, VietnamDivisionType.HUYEN, "huyen_cao_loc", 20),
  "D_184": VNDistrict(
      "Huyện Văn Quan", 184, VietnamDivisionType.HUYEN, "huyen_van_quan", 20),
  "D_185": VNDistrict(
      "Huyện Bắc Sơn", 185, VietnamDivisionType.HUYEN, "huyen_bac_son", 20),
  "D_186": VNDistrict(
      "Huyện Hữu Lũng", 186, VietnamDivisionType.HUYEN, "huyen_huu_lung", 20),
  "D_187": VNDistrict(
      "Huyện Chi Lăng", 187, VietnamDivisionType.HUYEN, "huyen_chi_lang", 20),
  "D_188": VNDistrict(
      "Huyện Lộc Bình", 188, VietnamDivisionType.HUYEN, "huyen_loc_binh", 20),
  "D_189": VNDistrict(
      "Huyện Đình Lập", 189, VietnamDivisionType.HUYEN, "huyen_dinh_lap", 20),
  "D_193": VNDistrict("Thành phố Hạ Long", 193, VietnamDivisionType.THANH_PHO,
      "thanh_pho_ha_long", 22),
  "D_194": VNDistrict("Thành phố Móng Cái", 194, VietnamDivisionType.THANH_PHO,
      "thanh_pho_mong_cai", 22),
  "D_195": VNDistrict("Thành phố Cẩm Phả", 195, VietnamDivisionType.THANH_PHO,
      "thanh_pho_cam_pha", 22),
  "D_196": VNDistrict("Thành phố Uông Bí", 196, VietnamDivisionType.THANH_PHO,
      "thanh_pho_uong_bi", 22),
  "D_198": VNDistrict(
      "Huyện Bình Liêu", 198, VietnamDivisionType.HUYEN, "huyen_binh_lieu", 22),
  "D_199": VNDistrict(
      "Huyện Tiên Yên", 199, VietnamDivisionType.HUYEN, "huyen_tien_yen", 22),
  "D_200": VNDistrict(
      "Huyện Đầm Hà", 200, VietnamDivisionType.HUYEN, "huyen_dam_ha", 22),
  "D_201": VNDistrict(
      "Huyện Hải Hà", 201, VietnamDivisionType.HUYEN, "huyen_hai_ha", 22),
  "D_202": VNDistrict(
      "Huyện Ba Chẽ", 202, VietnamDivisionType.HUYEN, "huyen_ba_che", 22),
  "D_203": VNDistrict(
      "Huyện Vân Đồn", 203, VietnamDivisionType.HUYEN, "huyen_van_don", 22),
  "D_205": VNDistrict("Thị xã Đông Triều", 205, VietnamDivisionType.THI_XA,
      "thi_xa_dong_trieu", 22),
  "D_206": VNDistrict("Thị xã Quảng Yên", 206, VietnamDivisionType.THI_XA,
      "thi_xa_quang_yen", 22),
  "D_207": VNDistrict(
      "Huyện Cô Tô", 207, VietnamDivisionType.HUYEN, "huyen_co_to", 22),
  "D_213": VNDistrict("Thành phố Bắc Giang", 213, VietnamDivisionType.THANH_PHO,
      "thanh_pho_bac_giang", 24),
  "D_215": VNDistrict(
      "Huyện Yên Thế", 215, VietnamDivisionType.HUYEN, "huyen_yen_the", 24),
  "D_216": VNDistrict(
      "Huyện Tân Yên", 216, VietnamDivisionType.HUYEN, "huyen_tan_yen", 24),
  "D_217": VNDistrict("Huyện Lạng Giang", 217, VietnamDivisionType.HUYEN,
      "huyen_lang_giang", 24),
  "D_218": VNDistrict(
      "Huyện Lục Nam", 218, VietnamDivisionType.HUYEN, "huyen_luc_nam", 24),
  "D_219": VNDistrict(
      "Huyện Lục Ngạn", 219, VietnamDivisionType.HUYEN, "huyen_luc_ngan", 24),
  "D_220": VNDistrict(
      "Huyện Sơn Động", 220, VietnamDivisionType.HUYEN, "huyen_son_dong", 24),
  "D_221": VNDistrict(
      "Huyện Yên Dũng", 221, VietnamDivisionType.HUYEN, "huyen_yen_dung", 24),
  "D_222": VNDistrict(
      "Huyện Việt Yên", 222, VietnamDivisionType.HUYEN, "huyen_viet_yen", 24),
  "D_223": VNDistrict(
      "Huyện Hiệp Hòa", 223, VietnamDivisionType.HUYEN, "huyen_hiep_hoa", 24),
  "D_227": VNDistrict("Thành phố Việt Trì", 227, VietnamDivisionType.THANH_PHO,
      "thanh_pho_viet_tri", 25),
  "D_228": VNDistrict(
      "Thị xã Phú Thọ", 228, VietnamDivisionType.THI_XA, "thi_xa_phu_tho", 25),
  "D_230": VNDistrict(
      "Huyện Đoan Hùng", 230, VietnamDivisionType.HUYEN, "huyen_doan_hung", 25),
  "D_231": VNDistrict(
      "Huyện Hạ Hoà", 231, VietnamDivisionType.HUYEN, "huyen_ha_hoa", 25),
  "D_232": VNDistrict(
      "Huyện Thanh Ba", 232, VietnamDivisionType.HUYEN, "huyen_thanh_ba", 25),
  "D_233": VNDistrict(
      "Huyện Phù Ninh", 233, VietnamDivisionType.HUYEN, "huyen_phu_ninh", 25),
  "D_234": VNDistrict(
      "Huyện Yên Lập", 234, VietnamDivisionType.HUYEN, "huyen_yen_lap", 25),
  "D_235": VNDistrict(
      "Huyện Cẩm Khê", 235, VietnamDivisionType.HUYEN, "huyen_cam_khe", 25),
  "D_236": VNDistrict(
      "Huyện Tam Nông", 236, VietnamDivisionType.HUYEN, "huyen_tam_nong", 25),
  "D_237": VNDistrict(
      "Huyện Lâm Thao", 237, VietnamDivisionType.HUYEN, "huyen_lam_thao", 25),
  "D_238": VNDistrict(
      "Huyện Thanh Sơn", 238, VietnamDivisionType.HUYEN, "huyen_thanh_son", 25),
  "D_239": VNDistrict("Huyện Thanh Thuỷ", 239, VietnamDivisionType.HUYEN,
      "huyen_thanh_thuy", 25),
  "D_240": VNDistrict(
      "Huyện Tân Sơn", 240, VietnamDivisionType.HUYEN, "huyen_tan_son", 25),
  "D_243": VNDistrict("Thành phố Vĩnh Yên", 243, VietnamDivisionType.THANH_PHO,
      "thanh_pho_vinh_yen", 26),
  "D_244": VNDistrict("Thành phố Phúc Yên", 244, VietnamDivisionType.THANH_PHO,
      "thanh_pho_phuc_yen", 26),
  "D_246": VNDistrict(
      "Huyện Lập Thạch", 246, VietnamDivisionType.HUYEN, "huyen_lap_thach", 26),
  "D_247": VNDistrict(
      "Huyện Tam Dương", 247, VietnamDivisionType.HUYEN, "huyen_tam_duong", 26),
  "D_248": VNDistrict(
      "Huyện Tam Đảo", 248, VietnamDivisionType.HUYEN, "huyen_tam_dao", 26),
  "D_249": VNDistrict("Huyện Bình Xuyên", 249, VietnamDivisionType.HUYEN,
      "huyen_binh_xuyen", 26),
  "D_251": VNDistrict(
      "Huyện Yên Lạc", 251, VietnamDivisionType.HUYEN, "huyen_yen_lac", 26),
  "D_252": VNDistrict("Huyện Vĩnh Tường", 252, VietnamDivisionType.HUYEN,
      "huyen_vinh_tuong", 26),
  "D_253": VNDistrict(
      "Huyện Sông Lô", 253, VietnamDivisionType.HUYEN, "huyen_song_lo", 26),
  "D_256": VNDistrict("Thành phố Bắc Ninh", 256, VietnamDivisionType.THANH_PHO,
      "thanh_pho_bac_ninh", 27),
  "D_258": VNDistrict(
      "Huyện Yên Phong", 258, VietnamDivisionType.HUYEN, "huyen_yen_phong", 27),
  "D_259": VNDistrict(
      "Huyện Quế Võ", 259, VietnamDivisionType.HUYEN, "huyen_que_vo", 27),
  "D_260": VNDistrict(
      "Huyện Tiên Du", 260, VietnamDivisionType.HUYEN, "huyen_tien_du", 27),
  "D_261": VNDistrict(
      "Thị xã Từ Sơn", 261, VietnamDivisionType.THI_XA, "thi_xa_tu_son", 27),
  "D_262": VNDistrict("Huyện Thuận Thành", 262, VietnamDivisionType.HUYEN,
      "huyen_thuan_thanh", 27),
  "D_263": VNDistrict(
      "Huyện Gia Bình", 263, VietnamDivisionType.HUYEN, "huyen_gia_binh", 27),
  "D_264": VNDistrict(
      "Huyện Lương Tài", 264, VietnamDivisionType.HUYEN, "huyen_luong_tai", 27),
  "D_288": VNDistrict("Thành phố Hải Dương", 288, VietnamDivisionType.THANH_PHO,
      "thanh_pho_hai_duong", 30),
  "D_290": VNDistrict("Thành phố Chí Linh", 290, VietnamDivisionType.THANH_PHO,
      "thanh_pho_chi_linh", 30),
  "D_291": VNDistrict(
      "Huyện Nam Sách", 291, VietnamDivisionType.HUYEN, "huyen_nam_sach", 30),
  "D_292": VNDistrict("Thị xã Kinh Môn", 292, VietnamDivisionType.THI_XA,
      "thi_xa_kinh_mon", 30),
  "D_293": VNDistrict(
      "Huyện Kim Thành", 293, VietnamDivisionType.HUYEN, "huyen_kim_thanh", 30),
  "D_294": VNDistrict(
      "Huyện Thanh Hà", 294, VietnamDivisionType.HUYEN, "huyen_thanh_ha", 30),
  "D_295": VNDistrict(
      "Huyện Cẩm Giàng", 295, VietnamDivisionType.HUYEN, "huyen_cam_giang", 30),
  "D_296": VNDistrict("Huyện Bình Giang", 296, VietnamDivisionType.HUYEN,
      "huyen_binh_giang", 30),
  "D_297": VNDistrict(
      "Huyện Gia Lộc", 297, VietnamDivisionType.HUYEN, "huyen_gia_loc", 30),
  "D_298": VNDistrict(
      "Huyện Tứ Kỳ", 298, VietnamDivisionType.HUYEN, "huyen_tu_ky", 30),
  "D_299": VNDistrict("Huyện Ninh Giang", 299, VietnamDivisionType.HUYEN,
      "huyen_ninh_giang", 30),
  "D_300": VNDistrict("Huyện Thanh Miện", 300, VietnamDivisionType.HUYEN,
      "huyen_thanh_mien", 30),
  "D_303": VNDistrict(
      "Quận Hồng Bàng", 303, VietnamDivisionType.QUAN, "quan_hong_bang", 31),
  "D_304": VNDistrict(
      "Quận Ngô Quyền", 304, VietnamDivisionType.QUAN, "quan_ngo_quyen", 31),
  "D_305": VNDistrict(
      "Quận Lê Chân", 305, VietnamDivisionType.QUAN, "quan_le_chan", 31),
  "D_306": VNDistrict(
      "Quận Hải An", 306, VietnamDivisionType.QUAN, "quan_hai_an", 31),
  "D_307": VNDistrict(
      "Quận Kiến An", 307, VietnamDivisionType.QUAN, "quan_kien_an", 31),
  "D_308": VNDistrict(
      "Quận Đồ Sơn", 308, VietnamDivisionType.QUAN, "quan_do_son", 31),
  "D_309": VNDistrict(
      "Quận Dương Kinh", 309, VietnamDivisionType.QUAN, "quan_duong_kinh", 31),
  "D_311": VNDistrict("Huyện Thuỷ Nguyên", 311, VietnamDivisionType.HUYEN,
      "huyen_thuy_nguyen", 31),
  "D_312": VNDistrict(
      "Huyện An Dương", 312, VietnamDivisionType.HUYEN, "huyen_an_duong", 31),
  "D_313": VNDistrict(
      "Huyện An Lão", 313, VietnamDivisionType.HUYEN, "huyen_an_lao", 31),
  "D_314": VNDistrict(
      "Huyện Kiến Thuỵ", 314, VietnamDivisionType.HUYEN, "huyen_kien_thuy", 31),
  "D_315": VNDistrict(
      "Huyện Tiên Lãng", 315, VietnamDivisionType.HUYEN, "huyen_tien_lang", 31),
  "D_316": VNDistrict(
      "Huyện Vĩnh Bảo", 316, VietnamDivisionType.HUYEN, "huyen_vinh_bao", 31),
  "D_317": VNDistrict(
      "Huyện Cát Hải", 317, VietnamDivisionType.HUYEN, "huyen_cat_hai", 31),
  "D_318": VNDistrict("Huyện Bạch Long Vĩ", 318, VietnamDivisionType.HUYEN,
      "huyen_bach_long_vi", 31),
  "D_323": VNDistrict("Thành phố Hưng Yên", 323, VietnamDivisionType.THANH_PHO,
      "thanh_pho_hung_yen", 33),
  "D_325": VNDistrict(
      "Huyện Văn Lâm", 325, VietnamDivisionType.HUYEN, "huyen_van_lam", 33),
  "D_326": VNDistrict(
      "Huyện Văn Giang", 326, VietnamDivisionType.HUYEN, "huyen_van_giang", 33),
  "D_327": VNDistrict(
      "Huyện Yên Mỹ", 327, VietnamDivisionType.HUYEN, "huyen_yen_my", 33),
  "D_328": VNDistrict(
      "Thị xã Mỹ Hào", 328, VietnamDivisionType.THI_XA, "thi_xa_my_hao", 33),
  "D_329": VNDistrict(
      "Huyện Ân Thi", 329, VietnamDivisionType.HUYEN, "huyen_an_thi", 33),
  "D_330": VNDistrict("Huyện Khoái Châu", 330, VietnamDivisionType.HUYEN,
      "huyen_khoai_chau", 33),
  "D_331": VNDistrict(
      "Huyện Kim Động", 331, VietnamDivisionType.HUYEN, "huyen_kim_dong", 33),
  "D_332": VNDistrict(
      "Huyện Tiên Lữ", 332, VietnamDivisionType.HUYEN, "huyen_tien_lu", 33),
  "D_333": VNDistrict(
      "Huyện Phù Cừ", 333, VietnamDivisionType.HUYEN, "huyen_phu_cu", 33),
  "D_336": VNDistrict("Thành phố Thái Bình", 336, VietnamDivisionType.THANH_PHO,
      "thanh_pho_thai_binh", 34),
  "D_338": VNDistrict(
      "Huyện Quỳnh Phụ", 338, VietnamDivisionType.HUYEN, "huyen_quynh_phu", 34),
  "D_339": VNDistrict(
      "Huyện Hưng Hà", 339, VietnamDivisionType.HUYEN, "huyen_hung_ha", 34),
  "D_340": VNDistrict(
      "Huyện Đông Hưng", 340, VietnamDivisionType.HUYEN, "huyen_dong_hung", 34),
  "D_341": VNDistrict(
      "Huyện Thái Thụy", 341, VietnamDivisionType.HUYEN, "huyen_thai_thuy", 34),
  "D_342": VNDistrict(
      "Huyện Tiền Hải", 342, VietnamDivisionType.HUYEN, "huyen_tien_hai", 34),
  "D_343": VNDistrict("Huyện Kiến Xương", 343, VietnamDivisionType.HUYEN,
      "huyen_kien_xuong", 34),
  "D_344": VNDistrict(
      "Huyện Vũ Thư", 344, VietnamDivisionType.HUYEN, "huyen_vu_thu", 34),
  "D_347": VNDistrict("Thành phố Phủ Lý", 347, VietnamDivisionType.THANH_PHO,
      "thanh_pho_phu_ly", 35),
  "D_349": VNDistrict("Thị xã Duy Tiên", 349, VietnamDivisionType.THI_XA,
      "thi_xa_duy_tien", 35),
  "D_350": VNDistrict(
      "Huyện Kim Bảng", 350, VietnamDivisionType.HUYEN, "huyen_kim_bang", 35),
  "D_351": VNDistrict("Huyện Thanh Liêm", 351, VietnamDivisionType.HUYEN,
      "huyen_thanh_liem", 35),
  "D_352": VNDistrict(
      "Huyện Bình Lục", 352, VietnamDivisionType.HUYEN, "huyen_binh_luc", 35),
  "D_353": VNDistrict(
      "Huyện Lý Nhân", 353, VietnamDivisionType.HUYEN, "huyen_ly_nhan", 35),
  "D_356": VNDistrict("Thành phố Nam Định", 356, VietnamDivisionType.THANH_PHO,
      "thanh_pho_nam_dinh", 36),
  "D_358": VNDistrict(
      "Huyện Mỹ Lộc", 358, VietnamDivisionType.HUYEN, "huyen_my_loc", 36),
  "D_359": VNDistrict(
      "Huyện Vụ Bản", 359, VietnamDivisionType.HUYEN, "huyen_vu_ban", 36),
  "D_360": VNDistrict(
      "Huyện Ý Yên", 360, VietnamDivisionType.HUYEN, "huyen_y_yen", 36),
  "D_361": VNDistrict("Huyện Nghĩa Hưng", 361, VietnamDivisionType.HUYEN,
      "huyen_nghia_hung", 36),
  "D_362": VNDistrict(
      "Huyện Nam Trực", 362, VietnamDivisionType.HUYEN, "huyen_nam_truc", 36),
  "D_363": VNDistrict(
      "Huyện Trực Ninh", 363, VietnamDivisionType.HUYEN, "huyen_truc_ninh", 36),
  "D_364": VNDistrict("Huyện Xuân Trường", 364, VietnamDivisionType.HUYEN,
      "huyen_xuan_truong", 36),
  "D_365": VNDistrict(
      "Huyện Giao Thủy", 365, VietnamDivisionType.HUYEN, "huyen_giao_thuy", 36),
  "D_366": VNDistrict(
      "Huyện Hải Hậu", 366, VietnamDivisionType.HUYEN, "huyen_hai_hau", 36),
  "D_369": VNDistrict("Thành phố Ninh Bình", 369, VietnamDivisionType.THANH_PHO,
      "thanh_pho_ninh_binh", 37),
  "D_370": VNDistrict("Thành phố Tam Điệp", 370, VietnamDivisionType.THANH_PHO,
      "thanh_pho_tam_diep", 37),
  "D_372": VNDistrict(
      "Huyện Nho Quan", 372, VietnamDivisionType.HUYEN, "huyen_nho_quan", 37),
  "D_373": VNDistrict(
      "Huyện Gia Viễn", 373, VietnamDivisionType.HUYEN, "huyen_gia_vien", 37),
  "D_374": VNDistrict(
      "Huyện Hoa Lư", 374, VietnamDivisionType.HUYEN, "huyen_hoa_lu", 37),
  "D_375": VNDistrict(
      "Huyện Yên Khánh", 375, VietnamDivisionType.HUYEN, "huyen_yen_khanh", 37),
  "D_376": VNDistrict(
      "Huyện Kim Sơn", 376, VietnamDivisionType.HUYEN, "huyen_kim_son", 37),
  "D_377": VNDistrict(
      "Huyện Yên Mô", 377, VietnamDivisionType.HUYEN, "huyen_yen_mo", 37),
  "D_380": VNDistrict("Thành phố Thanh Hóa", 380, VietnamDivisionType.THANH_PHO,
      "thanh_pho_thanh_hoa", 38),
  "D_381": VNDistrict(
      "Thị xã Bỉm Sơn", 381, VietnamDivisionType.THI_XA, "thi_xa_bim_son", 38),
  "D_382": VNDistrict("Thành phố Sầm Sơn", 382, VietnamDivisionType.THANH_PHO,
      "thanh_pho_sam_son", 38),
  "D_384": VNDistrict(
      "Huyện Mường Lát", 384, VietnamDivisionType.HUYEN, "huyen_muong_lat", 38),
  "D_385": VNDistrict(
      "Huyện Quan Hóa", 385, VietnamDivisionType.HUYEN, "huyen_quan_hoa", 38),
  "D_386": VNDistrict(
      "Huyện Bá Thước", 386, VietnamDivisionType.HUYEN, "huyen_ba_thuoc", 38),
  "D_387": VNDistrict(
      "Huyện Quan Sơn", 387, VietnamDivisionType.HUYEN, "huyen_quan_son", 38),
  "D_388": VNDistrict("Huyện Lang Chánh", 388, VietnamDivisionType.HUYEN,
      "huyen_lang_chanh", 38),
  "D_389": VNDistrict(
      "Huyện Ngọc Lặc", 389, VietnamDivisionType.HUYEN, "huyen_ngoc_lac", 38),
  "D_390": VNDistrict(
      "Huyện Cẩm Thủy", 390, VietnamDivisionType.HUYEN, "huyen_cam_thuy", 38),
  "D_391": VNDistrict("Huyện Thạch Thành", 391, VietnamDivisionType.HUYEN,
      "huyen_thach_thanh", 38),
  "D_392": VNDistrict(
      "Huyện Hà Trung", 392, VietnamDivisionType.HUYEN, "huyen_ha_trung", 38),
  "D_393": VNDistrict(
      "Huyện Vĩnh Lộc", 393, VietnamDivisionType.HUYEN, "huyen_vinh_loc", 38),
  "D_394": VNDistrict(
      "Huyện Yên Định", 394, VietnamDivisionType.HUYEN, "huyen_yen_dinh", 38),
  "D_395": VNDistrict(
      "Huyện Thọ Xuân", 395, VietnamDivisionType.HUYEN, "huyen_tho_xuan", 38),
  "D_396": VNDistrict("Huyện Thường Xuân", 396, VietnamDivisionType.HUYEN,
      "huyen_thuong_xuan", 38),
  "D_397": VNDistrict(
      "Huyện Triệu Sơn", 397, VietnamDivisionType.HUYEN, "huyen_trieu_son", 38),
  "D_398": VNDistrict(
      "Huyện Thiệu Hóa", 398, VietnamDivisionType.HUYEN, "huyen_thieu_hoa", 38),
  "D_399": VNDistrict(
      "Huyện Hoằng Hóa", 399, VietnamDivisionType.HUYEN, "huyen_hoang_hoa", 38),
  "D_400": VNDistrict(
      "Huyện Hậu Lộc", 400, VietnamDivisionType.HUYEN, "huyen_hau_loc", 38),
  "D_401": VNDistrict(
      "Huyện Nga Sơn", 401, VietnamDivisionType.HUYEN, "huyen_nga_son", 38),
  "D_402": VNDistrict(
      "Huyện Như Xuân", 402, VietnamDivisionType.HUYEN, "huyen_nhu_xuan", 38),
  "D_403": VNDistrict(
      "Huyện Như Thanh", 403, VietnamDivisionType.HUYEN, "huyen_nhu_thanh", 38),
  "D_404": VNDistrict(
      "Huyện Nông Cống", 404, VietnamDivisionType.HUYEN, "huyen_nong_cong", 38),
  "D_405": VNDistrict(
      "Huyện Đông Sơn", 405, VietnamDivisionType.HUYEN, "huyen_dong_son", 38),
  "D_406": VNDistrict("Huyện Quảng Xương", 406, VietnamDivisionType.HUYEN,
      "huyen_quang_xuong", 38),
  "D_407": VNDistrict("Thị xã Nghi Sơn", 407, VietnamDivisionType.THI_XA,
      "thi_xa_nghi_son", 38),
  "D_412": VNDistrict("Thành phố Vinh", 412, VietnamDivisionType.THANH_PHO,
      "thanh_pho_vinh", 40),
  "D_413": VNDistrict(
      "Thị xã Cửa Lò", 413, VietnamDivisionType.THI_XA, "thi_xa_cua_lo", 40),
  "D_414": VNDistrict("Thị xã Thái Hoà", 414, VietnamDivisionType.THI_XA,
      "thi_xa_thai_hoa", 40),
  "D_415": VNDistrict(
      "Huyện Quế Phong", 415, VietnamDivisionType.HUYEN, "huyen_que_phong", 40),
  "D_416": VNDistrict(
      "Huyện Quỳ Châu", 416, VietnamDivisionType.HUYEN, "huyen_quy_chau", 40),
  "D_417": VNDistrict(
      "Huyện Kỳ Sơn", 417, VietnamDivisionType.HUYEN, "huyen_ky_son", 40),
  "D_418": VNDistrict("Huyện Tương Dương", 418, VietnamDivisionType.HUYEN,
      "huyen_tuong_duong", 40),
  "D_419": VNDistrict(
      "Huyện Nghĩa Đàn", 419, VietnamDivisionType.HUYEN, "huyen_nghia_dan", 40),
  "D_420": VNDistrict(
      "Huyện Quỳ Hợp", 420, VietnamDivisionType.HUYEN, "huyen_quy_hop", 40),
  "D_421": VNDistrict(
      "Huyện Quỳnh Lưu", 421, VietnamDivisionType.HUYEN, "huyen_quynh_luu", 40),
  "D_422": VNDistrict(
      "Huyện Con Cuông", 422, VietnamDivisionType.HUYEN, "huyen_con_cuong", 40),
  "D_423": VNDistrict(
      "Huyện Tân Kỳ", 423, VietnamDivisionType.HUYEN, "huyen_tan_ky", 40),
  "D_424": VNDistrict(
      "Huyện Anh Sơn", 424, VietnamDivisionType.HUYEN, "huyen_anh_son", 40),
  "D_425": VNDistrict(
      "Huyện Diễn Châu", 425, VietnamDivisionType.HUYEN, "huyen_dien_chau", 40),
  "D_426": VNDistrict(
      "Huyện Yên Thành", 426, VietnamDivisionType.HUYEN, "huyen_yen_thanh", 40),
  "D_427": VNDistrict(
      "Huyện Đô Lương", 427, VietnamDivisionType.HUYEN, "huyen_do_luong", 40),
  "D_428": VNDistrict("Huyện Thanh Chương", 428, VietnamDivisionType.HUYEN,
      "huyen_thanh_chuong", 40),
  "D_429": VNDistrict(
      "Huyện Nghi Lộc", 429, VietnamDivisionType.HUYEN, "huyen_nghi_loc", 40),
  "D_430": VNDistrict(
      "Huyện Nam Đàn", 430, VietnamDivisionType.HUYEN, "huyen_nam_dan", 40),
  "D_431": VNDistrict("Huyện Hưng Nguyên", 431, VietnamDivisionType.HUYEN,
      "huyen_hung_nguyen", 40),
  "D_432": VNDistrict("Thị xã Hoàng Mai", 432, VietnamDivisionType.THI_XA,
      "thi_xa_hoang_mai", 40),
  "D_436": VNDistrict("Thành phố Hà Tĩnh", 436, VietnamDivisionType.THANH_PHO,
      "thanh_pho_ha_tinh", 42),
  "D_437": VNDistrict("Thị xã Hồng Lĩnh", 437, VietnamDivisionType.THI_XA,
      "thi_xa_hong_linh", 42),
  "D_439": VNDistrict(
      "Huyện Hương Sơn", 439, VietnamDivisionType.HUYEN, "huyen_huong_son", 42),
  "D_440": VNDistrict(
      "Huyện Đức Thọ", 440, VietnamDivisionType.HUYEN, "huyen_duc_tho", 42),
  "D_441": VNDistrict(
      "Huyện Vũ Quang", 441, VietnamDivisionType.HUYEN, "huyen_vu_quang", 42),
  "D_442": VNDistrict(
      "Huyện Nghi Xuân", 442, VietnamDivisionType.HUYEN, "huyen_nghi_xuan", 42),
  "D_443": VNDistrict(
      "Huyện Can Lộc", 443, VietnamDivisionType.HUYEN, "huyen_can_loc", 42),
  "D_444": VNDistrict(
      "Huyện Hương Khê", 444, VietnamDivisionType.HUYEN, "huyen_huong_khe", 42),
  "D_445": VNDistrict(
      "Huyện Thạch Hà", 445, VietnamDivisionType.HUYEN, "huyen_thach_ha", 42),
  "D_446": VNDistrict(
      "Huyện Cẩm Xuyên", 446, VietnamDivisionType.HUYEN, "huyen_cam_xuyen", 42),
  "D_447": VNDistrict(
      "Huyện Kỳ Anh", 447, VietnamDivisionType.HUYEN, "huyen_ky_anh", 42),
  "D_448": VNDistrict(
      "Huyện Lộc Hà", 448, VietnamDivisionType.HUYEN, "huyen_loc_ha", 42),
  "D_449": VNDistrict(
      "Thị xã Kỳ Anh", 449, VietnamDivisionType.THI_XA, "thi_xa_ky_anh", 42),
  "D_450": VNDistrict("Thành Phố Đồng Hới", 450, VietnamDivisionType.THANH_PHO,
      "thanh_pho_dong_hoi", 44),
  "D_452": VNDistrict(
      "Huyện Minh Hóa", 452, VietnamDivisionType.HUYEN, "huyen_minh_hoa", 44),
  "D_453": VNDistrict(
      "Huyện Tuyên Hóa", 453, VietnamDivisionType.HUYEN, "huyen_tuyen_hoa", 44),
  "D_454": VNDistrict("Huyện Quảng Trạch", 454, VietnamDivisionType.HUYEN,
      "huyen_quang_trach", 44),
  "D_455": VNDistrict(
      "Huyện Bố Trạch", 455, VietnamDivisionType.HUYEN, "huyen_bo_trach", 44),
  "D_456": VNDistrict("Huyện Quảng Ninh", 456, VietnamDivisionType.HUYEN,
      "huyen_quang_ninh", 44),
  "D_457": VNDistrict(
      "Huyện Lệ Thủy", 457, VietnamDivisionType.HUYEN, "huyen_le_thuy", 44),
  "D_458": VNDistrict(
      "Thị xã Ba Đồn", 458, VietnamDivisionType.THI_XA, "thi_xa_ba_don", 44),
  "D_461": VNDistrict("Thành phố Đông Hà", 461, VietnamDivisionType.THANH_PHO,
      "thanh_pho_dong_ha", 45),
  "D_462": VNDistrict("Thị xã Quảng Trị", 462, VietnamDivisionType.THI_XA,
      "thi_xa_quang_tri", 45),
  "D_464": VNDistrict(
      "Huyện Vĩnh Linh", 464, VietnamDivisionType.HUYEN, "huyen_vinh_linh", 45),
  "D_465": VNDistrict(
      "Huyện Hướng Hóa", 465, VietnamDivisionType.HUYEN, "huyen_huong_hoa", 45),
  "D_466": VNDistrict(
      "Huyện Gio Linh", 466, VietnamDivisionType.HUYEN, "huyen_gio_linh", 45),
  "D_467": VNDistrict(
      "Huyện Đa Krông", 467, VietnamDivisionType.HUYEN, "huyen_da_krong", 45),
  "D_468": VNDistrict(
      "Huyện Cam Lộ", 468, VietnamDivisionType.HUYEN, "huyen_cam_lo", 45),
  "D_469": VNDistrict("Huyện Triệu Phong", 469, VietnamDivisionType.HUYEN,
      "huyen_trieu_phong", 45),
  "D_470": VNDistrict(
      "Huyện Hải Lăng", 470, VietnamDivisionType.HUYEN, "huyen_hai_lang", 45),
  "D_471": VNDistrict(
      "Huyện Cồn Cỏ", 471, VietnamDivisionType.HUYEN, "huyen_con_co", 45),
  "D_474": VNDistrict(
      "Thành phố Huế", 474, VietnamDivisionType.THANH_PHO, "thanh_pho_hue", 46),
  "D_476": VNDistrict("Huyện Phong Điền", 476, VietnamDivisionType.HUYEN,
      "huyen_phong_dien", 46),
  "D_477": VNDistrict("Huyện Quảng Điền", 477, VietnamDivisionType.HUYEN,
      "huyen_quang_dien", 46),
  "D_478": VNDistrict(
      "Huyện Phú Vang", 478, VietnamDivisionType.HUYEN, "huyen_phu_vang", 46),
  "D_479": VNDistrict("Thị xã Hương Thủy", 479, VietnamDivisionType.THI_XA,
      "thi_xa_huong_thuy", 46),
  "D_480": VNDistrict("Thị xã Hương Trà", 480, VietnamDivisionType.THI_XA,
      "thi_xa_huong_tra", 46),
  "D_481": VNDistrict(
      "Huyện A Lưới", 481, VietnamDivisionType.HUYEN, "huyen_a_luoi", 46),
  "D_482": VNDistrict(
      "Huyện Phú Lộc", 482, VietnamDivisionType.HUYEN, "huyen_phu_loc", 46),
  "D_483": VNDistrict(
      "Huyện Nam Đông", 483, VietnamDivisionType.HUYEN, "huyen_nam_dong", 46),
  "D_490": VNDistrict(
      "Quận Liên Chiểu", 490, VietnamDivisionType.QUAN, "quan_lien_chieu", 48),
  "D_491": VNDistrict(
      "Quận Thanh Khê", 491, VietnamDivisionType.QUAN, "quan_thanh_khe", 48),
  "D_492": VNDistrict(
      "Quận Hải Châu", 492, VietnamDivisionType.QUAN, "quan_hai_chau", 48),
  "D_493": VNDistrict(
      "Quận Sơn Trà", 493, VietnamDivisionType.QUAN, "quan_son_tra", 48),
  "D_494": VNDistrict("Quận Ngũ Hành Sơn", 494, VietnamDivisionType.QUAN,
      "quan_ngu_hanh_son", 48),
  "D_495": VNDistrict(
      "Quận Cẩm Lệ", 495, VietnamDivisionType.QUAN, "quan_cam_le", 48),
  "D_497": VNDistrict(
      "Huyện Hòa Vang", 497, VietnamDivisionType.HUYEN, "huyen_hoa_vang", 48),
  "D_498": VNDistrict(
      "Huyện Hoàng Sa", 498, VietnamDivisionType.HUYEN, "huyen_hoang_sa", 48),
  "D_502": VNDistrict("Thành phố Tam Kỳ", 502, VietnamDivisionType.THANH_PHO,
      "thanh_pho_tam_ky", 49),
  "D_503": VNDistrict("Thành phố Hội An", 503, VietnamDivisionType.THANH_PHO,
      "thanh_pho_hoi_an", 49),
  "D_504": VNDistrict(
      "Huyện Tây Giang", 504, VietnamDivisionType.HUYEN, "huyen_tay_giang", 49),
  "D_505": VNDistrict("Huyện Đông Giang", 505, VietnamDivisionType.HUYEN,
      "huyen_dong_giang", 49),
  "D_506": VNDistrict(
      "Huyện Đại Lộc", 506, VietnamDivisionType.HUYEN, "huyen_dai_loc", 49),
  "D_507": VNDistrict("Thị xã Điện Bàn", 507, VietnamDivisionType.THI_XA,
      "thi_xa_dien_ban", 49),
  "D_508": VNDistrict(
      "Huyện Duy Xuyên", 508, VietnamDivisionType.HUYEN, "huyen_duy_xuyen", 49),
  "D_509": VNDistrict(
      "Huyện Quế Sơn", 509, VietnamDivisionType.HUYEN, "huyen_que_son", 49),
  "D_510": VNDistrict(
      "Huyện Nam Giang", 510, VietnamDivisionType.HUYEN, "huyen_nam_giang", 49),
  "D_511": VNDistrict(
      "Huyện Phước Sơn", 511, VietnamDivisionType.HUYEN, "huyen_phuoc_son", 49),
  "D_512": VNDistrict(
      "Huyện Hiệp Đức", 512, VietnamDivisionType.HUYEN, "huyen_hiep_duc", 49),
  "D_513": VNDistrict("Huyện Thăng Bình", 513, VietnamDivisionType.HUYEN,
      "huyen_thang_binh", 49),
  "D_514": VNDistrict("Huyện Tiên Phước", 514, VietnamDivisionType.HUYEN,
      "huyen_tien_phuoc", 49),
  "D_515": VNDistrict("Huyện Bắc Trà My", 515, VietnamDivisionType.HUYEN,
      "huyen_bac_tra_my", 49),
  "D_516": VNDistrict("Huyện Nam Trà My", 516, VietnamDivisionType.HUYEN,
      "huyen_nam_tra_my", 49),
  "D_517": VNDistrict(
      "Huyện Núi Thành", 517, VietnamDivisionType.HUYEN, "huyen_nui_thanh", 49),
  "D_518": VNDistrict(
      "Huyện Phú Ninh", 518, VietnamDivisionType.HUYEN, "huyen_phu_ninh", 49),
  "D_519": VNDistrict(
      "Huyện Nông Sơn", 519, VietnamDivisionType.HUYEN, "huyen_nong_son", 49),
  "D_522": VNDistrict("Thành phố Quảng Ngãi", 522,
      VietnamDivisionType.THANH_PHO, "thanh_pho_quang_ngai", 51),
  "D_524": VNDistrict(
      "Huyện Bình Sơn", 524, VietnamDivisionType.HUYEN, "huyen_binh_son", 51),
  "D_525": VNDistrict(
      "Huyện Trà Bồng", 525, VietnamDivisionType.HUYEN, "huyen_tra_bong", 51),
  "D_527": VNDistrict(
      "Huyện Sơn Tịnh", 527, VietnamDivisionType.HUYEN, "huyen_son_tinh", 51),
  "D_528": VNDistrict(
      "Huyện Tư Nghĩa", 528, VietnamDivisionType.HUYEN, "huyen_tu_nghia", 51),
  "D_529": VNDistrict(
      "Huyện Sơn Hà", 529, VietnamDivisionType.HUYEN, "huyen_son_ha", 51),
  "D_530": VNDistrict(
      "Huyện Sơn Tây", 530, VietnamDivisionType.HUYEN, "huyen_son_tay", 51),
  "D_531": VNDistrict(
      "Huyện Minh Long", 531, VietnamDivisionType.HUYEN, "huyen_minh_long", 51),
  "D_532": VNDistrict("Huyện Nghĩa Hành", 532, VietnamDivisionType.HUYEN,
      "huyen_nghia_hanh", 51),
  "D_533": VNDistrict(
      "Huyện Mộ Đức", 533, VietnamDivisionType.HUYEN, "huyen_mo_duc", 51),
  "D_534": VNDistrict(
      "Thị xã Đức Phổ", 534, VietnamDivisionType.THI_XA, "thi_xa_duc_pho", 51),
  "D_535": VNDistrict(
      "Huyện Ba Tơ", 535, VietnamDivisionType.HUYEN, "huyen_ba_to", 51),
  "D_536": VNDistrict(
      "Huyện Lý Sơn", 536, VietnamDivisionType.HUYEN, "huyen_ly_son", 51),
  "D_540": VNDistrict("Thành phố Quy Nhơn", 540, VietnamDivisionType.THANH_PHO,
      "thanh_pho_quy_nhon", 52),
  "D_542": VNDistrict(
      "Huyện An Lão", 542, VietnamDivisionType.HUYEN, "huyen_an_lao", 52),
  "D_543": VNDistrict("Thị xã Hoài Nhơn", 543, VietnamDivisionType.THI_XA,
      "thi_xa_hoai_nhon", 52),
  "D_544": VNDistrict(
      "Huyện Hoài Ân", 544, VietnamDivisionType.HUYEN, "huyen_hoai_an", 52),
  "D_545": VNDistrict(
      "Huyện Phù Mỹ", 545, VietnamDivisionType.HUYEN, "huyen_phu_my", 52),
  "D_546": VNDistrict("Huyện Vĩnh Thạnh", 546, VietnamDivisionType.HUYEN,
      "huyen_vinh_thanh", 52),
  "D_547": VNDistrict(
      "Huyện Tây Sơn", 547, VietnamDivisionType.HUYEN, "huyen_tay_son", 52),
  "D_548": VNDistrict(
      "Huyện Phù Cát", 548, VietnamDivisionType.HUYEN, "huyen_phu_cat", 52),
  "D_549": VNDistrict(
      "Thị xã An Nhơn", 549, VietnamDivisionType.THI_XA, "thi_xa_an_nhon", 52),
  "D_550": VNDistrict(
      "Huyện Tuy Phước", 550, VietnamDivisionType.HUYEN, "huyen_tuy_phuoc", 52),
  "D_551": VNDistrict(
      "Huyện Vân Canh", 551, VietnamDivisionType.HUYEN, "huyen_van_canh", 52),
  "D_555": VNDistrict("Thành phố Tuy Hoà", 555, VietnamDivisionType.THANH_PHO,
      "thanh_pho_tuy_hoa", 54),
  "D_557": VNDistrict("Thị xã Sông Cầu", 557, VietnamDivisionType.THI_XA,
      "thi_xa_song_cau", 54),
  "D_558": VNDistrict(
      "Huyện Đồng Xuân", 558, VietnamDivisionType.HUYEN, "huyen_dong_xuan", 54),
  "D_559": VNDistrict(
      "Huyện Tuy An", 559, VietnamDivisionType.HUYEN, "huyen_tuy_an", 54),
  "D_560": VNDistrict(
      "Huyện Sơn Hòa", 560, VietnamDivisionType.HUYEN, "huyen_son_hoa", 54),
  "D_561": VNDistrict(
      "Huyện Sông Hinh", 561, VietnamDivisionType.HUYEN, "huyen_song_hinh", 54),
  "D_562": VNDistrict(
      "Huyện Tây Hoà", 562, VietnamDivisionType.HUYEN, "huyen_tay_hoa", 54),
  "D_563": VNDistrict(
      "Huyện Phú Hoà", 563, VietnamDivisionType.HUYEN, "huyen_phu_hoa", 54),
  "D_564": VNDistrict("Thị xã Đông Hòa", 564, VietnamDivisionType.THI_XA,
      "thi_xa_dong_hoa", 54),
  "D_568": VNDistrict("Thành phố Nha Trang", 568, VietnamDivisionType.THANH_PHO,
      "thanh_pho_nha_trang", 56),
  "D_569": VNDistrict("Thành phố Cam Ranh", 569, VietnamDivisionType.THANH_PHO,
      "thanh_pho_cam_ranh", 56),
  "D_570": VNDistrict(
      "Huyện Cam Lâm", 570, VietnamDivisionType.HUYEN, "huyen_cam_lam", 56),
  "D_571": VNDistrict(
      "Huyện Vạn Ninh", 571, VietnamDivisionType.HUYEN, "huyen_van_ninh", 56),
  "D_572": VNDistrict("Thị xã Ninh Hòa", 572, VietnamDivisionType.THI_XA,
      "thi_xa_ninh_hoa", 56),
  "D_573": VNDistrict("Huyện Khánh Vĩnh", 573, VietnamDivisionType.HUYEN,
      "huyen_khanh_vinh", 56),
  "D_574": VNDistrict("Huyện Diên Khánh", 574, VietnamDivisionType.HUYEN,
      "huyen_dien_khanh", 56),
  "D_575": VNDistrict(
      "Huyện Khánh Sơn", 575, VietnamDivisionType.HUYEN, "huyen_khanh_son", 56),
  "D_576": VNDistrict(
      "Huyện Trường Sa", 576, VietnamDivisionType.HUYEN, "huyen_truong_sa", 56),
  "D_582": VNDistrict("Thành phố Phan Rang-Tháp Chàm", 582,
      VietnamDivisionType.THANH_PHO, "thanh_pho_phan_rang_thap_cham", 58),
  "D_584": VNDistrict(
      "Huyện Bác Ái", 584, VietnamDivisionType.HUYEN, "huyen_bac_ai", 58),
  "D_585": VNDistrict(
      "Huyện Ninh Sơn", 585, VietnamDivisionType.HUYEN, "huyen_ninh_son", 58),
  "D_586": VNDistrict(
      "Huyện Ninh Hải", 586, VietnamDivisionType.HUYEN, "huyen_ninh_hai", 58),
  "D_587": VNDistrict("Huyện Ninh Phước", 587, VietnamDivisionType.HUYEN,
      "huyen_ninh_phuoc", 58),
  "D_588": VNDistrict(
      "Huyện Thuận Bắc", 588, VietnamDivisionType.HUYEN, "huyen_thuan_bac", 58),
  "D_589": VNDistrict(
      "Huyện Thuận Nam", 589, VietnamDivisionType.HUYEN, "huyen_thuan_nam", 58),
  "D_593": VNDistrict("Thành phố Phan Thiết", 593,
      VietnamDivisionType.THANH_PHO, "thanh_pho_phan_thiet", 60),
  "D_594": VNDistrict(
      "Thị xã La Gi", 594, VietnamDivisionType.THI_XA, "thi_xa_la_gi", 60),
  "D_595": VNDistrict(
      "Huyện Tuy Phong", 595, VietnamDivisionType.HUYEN, "huyen_tuy_phong", 60),
  "D_596": VNDistrict(
      "Huyện Bắc Bình", 596, VietnamDivisionType.HUYEN, "huyen_bac_binh", 60),
  "D_597": VNDistrict("Huyện Hàm Thuận Bắc", 597, VietnamDivisionType.HUYEN,
      "huyen_ham_thuan_bac", 60),
  "D_598": VNDistrict("Huyện Hàm Thuận Nam", 598, VietnamDivisionType.HUYEN,
      "huyen_ham_thuan_nam", 60),
  "D_599": VNDistrict(
      "Huyện Tánh Linh", 599, VietnamDivisionType.HUYEN, "huyen_tanh_linh", 60),
  "D_600": VNDistrict(
      "Huyện Đức Linh", 600, VietnamDivisionType.HUYEN, "huyen_duc_linh", 60),
  "D_601": VNDistrict(
      "Huyện Hàm Tân", 601, VietnamDivisionType.HUYEN, "huyen_ham_tan", 60),
  "D_602": VNDistrict(
      "Huyện Phú Quí", 602, VietnamDivisionType.HUYEN, "huyen_phu_qui", 60),
  "D_608": VNDistrict("Thành phố Kon Tum", 608, VietnamDivisionType.THANH_PHO,
      "thanh_pho_kon_tum", 62),
  "D_610": VNDistrict(
      "Huyện Đắk Glei", 610, VietnamDivisionType.HUYEN, "huyen_dak_glei", 62),
  "D_611": VNDistrict(
      "Huyện Ngọc Hồi", 611, VietnamDivisionType.HUYEN, "huyen_ngoc_hoi", 62),
  "D_612": VNDistrict(
      "Huyện Đắk Tô", 612, VietnamDivisionType.HUYEN, "huyen_dak_to", 62),
  "D_613": VNDistrict(
      "Huyện Kon Plông", 613, VietnamDivisionType.HUYEN, "huyen_kon_plong", 62),
  "D_614": VNDistrict(
      "Huyện Kon Rẫy", 614, VietnamDivisionType.HUYEN, "huyen_kon_ray", 62),
  "D_615": VNDistrict(
      "Huyện Đắk Hà", 615, VietnamDivisionType.HUYEN, "huyen_dak_ha", 62),
  "D_616": VNDistrict(
      "Huyện Sa Thầy", 616, VietnamDivisionType.HUYEN, "huyen_sa_thay", 62),
  "D_617": VNDistrict("Huyện Tu Mơ Rông", 617, VietnamDivisionType.HUYEN,
      "huyen_tu_mo_rong", 62),
  "D_618": VNDistrict("Huyện Ia H' Drai", 618, VietnamDivisionType.HUYEN,
      "huyen_ia_h_drai", 62),
  "D_622": VNDistrict("Thành phố Pleiku", 622, VietnamDivisionType.THANH_PHO,
      "thanh_pho_pleiku", 64),
  "D_623": VNDistrict(
      "Thị xã An Khê", 623, VietnamDivisionType.THI_XA, "thi_xa_an_khe", 64),
  "D_624": VNDistrict(
      "Thị xã Ayun Pa", 624, VietnamDivisionType.THI_XA, "thi_xa_ayun_pa", 64),
  "D_625": VNDistrict(
      "Huyện KBang", 625, VietnamDivisionType.HUYEN, "huyen_kbang", 64),
  "D_626": VNDistrict(
      "Huyện Đăk Đoa", 626, VietnamDivisionType.HUYEN, "huyen_dak_doa", 64),
  "D_627": VNDistrict(
      "Huyện Chư Păh", 627, VietnamDivisionType.HUYEN, "huyen_chu_pah", 64),
  "D_628": VNDistrict(
      "Huyện Ia Grai", 628, VietnamDivisionType.HUYEN, "huyen_ia_grai", 64),
  "D_629": VNDistrict(
      "Huyện Mang Yang", 629, VietnamDivisionType.HUYEN, "huyen_mang_yang", 64),
  "D_630": VNDistrict(
      "Huyện Kông Chro", 630, VietnamDivisionType.HUYEN, "huyen_kong_chro", 64),
  "D_631": VNDistrict(
      "Huyện Đức Cơ", 631, VietnamDivisionType.HUYEN, "huyen_duc_co", 64),
  "D_632": VNDistrict(
      "Huyện Chư Prông", 632, VietnamDivisionType.HUYEN, "huyen_chu_prong", 64),
  "D_633": VNDistrict(
      "Huyện Chư Sê", 633, VietnamDivisionType.HUYEN, "huyen_chu_se", 64),
  "D_634": VNDistrict(
      "Huyện Đăk Pơ", 634, VietnamDivisionType.HUYEN, "huyen_dak_po", 64),
  "D_635": VNDistrict(
      "Huyện Ia Pa", 635, VietnamDivisionType.HUYEN, "huyen_ia_pa", 64),
  "D_637": VNDistrict(
      "Huyện Krông Pa", 637, VietnamDivisionType.HUYEN, "huyen_krong_pa", 64),
  "D_638": VNDistrict(
      "Huyện Phú Thiện", 638, VietnamDivisionType.HUYEN, "huyen_phu_thien", 64),
  "D_639": VNDistrict(
      "Huyện Chư Pưh", 639, VietnamDivisionType.HUYEN, "huyen_chu_puh", 64),
  "D_643": VNDistrict("Thành phố Buôn Ma Thuột", 643,
      VietnamDivisionType.THANH_PHO, "thanh_pho_buon_ma_thuot", 66),
  "D_644": VNDistrict(
      "Thị xã Buôn Hồ", 644, VietnamDivisionType.THI_XA, "thi_xa_buon_ho", 66),
  "D_645": VNDistrict(
      "Huyện Ea H'leo", 645, VietnamDivisionType.HUYEN, "huyen_ea_hleo", 66),
  "D_646": VNDistrict(
      "Huyện Ea Súp", 646, VietnamDivisionType.HUYEN, "huyen_ea_sup", 66),
  "D_647": VNDistrict(
      "Huyện Buôn Đôn", 647, VietnamDivisionType.HUYEN, "huyen_buon_don", 66),
  "D_648": VNDistrict(
      "Huyện Cư M'gar", 648, VietnamDivisionType.HUYEN, "huyen_cu_mgar", 66),
  "D_649": VNDistrict(
      "Huyện Krông Búk", 649, VietnamDivisionType.HUYEN, "huyen_krong_buk", 66),
  "D_650": VNDistrict("Huyện Krông Năng", 650, VietnamDivisionType.HUYEN,
      "huyen_krong_nang", 66),
  "D_651": VNDistrict(
      "Huyện Ea Kar", 651, VietnamDivisionType.HUYEN, "huyen_ea_kar", 66),
  "D_652": VNDistrict(
      "Huyện M'Đrắk", 652, VietnamDivisionType.HUYEN, "huyen_mdrak", 66),
  "D_653": VNDistrict("Huyện Krông Bông", 653, VietnamDivisionType.HUYEN,
      "huyen_krong_bong", 66),
  "D_654": VNDistrict(
      "Huyện Krông Pắc", 654, VietnamDivisionType.HUYEN, "huyen_krong_pac", 66),
  "D_655": VNDistrict("Huyện Krông A Na", 655, VietnamDivisionType.HUYEN,
      "huyen_krong_a_na", 66),
  "D_656":
      VNDistrict("Huyện Lắk", 656, VietnamDivisionType.HUYEN, "huyen_lak", 66),
  "D_657": VNDistrict(
      "Huyện Cư Kuin", 657, VietnamDivisionType.HUYEN, "huyen_cu_kuin", 66),
  "D_660": VNDistrict("Thành phố Gia Nghĩa", 660, VietnamDivisionType.THANH_PHO,
      "thanh_pho_gia_nghia", 67),
  "D_661": VNDistrict(
      "Huyện Đăk Glong", 661, VietnamDivisionType.HUYEN, "huyen_dak_glong", 67),
  "D_662": VNDistrict(
      "Huyện Cư Jút", 662, VietnamDivisionType.HUYEN, "huyen_cu_jut", 67),
  "D_663": VNDistrict(
      "Huyện Đắk Mil", 663, VietnamDivisionType.HUYEN, "huyen_dak_mil", 67),
  "D_664": VNDistrict(
      "Huyện Krông Nô", 664, VietnamDivisionType.HUYEN, "huyen_krong_no", 67),
  "D_665": VNDistrict(
      "Huyện Đắk Song", 665, VietnamDivisionType.HUYEN, "huyen_dak_song", 67),
  "D_666": VNDistrict(
      "Huyện Đắk R'Lấp", 666, VietnamDivisionType.HUYEN, "huyen_dak_rlap", 67),
  "D_667": VNDistrict(
      "Huyện Tuy Đức", 667, VietnamDivisionType.HUYEN, "huyen_tuy_duc", 67),
  "D_672": VNDistrict("Thành phố Đà Lạt", 672, VietnamDivisionType.THANH_PHO,
      "thanh_pho_da_lat", 68),
  "D_673": VNDistrict("Thành phố Bảo Lộc", 673, VietnamDivisionType.THANH_PHO,
      "thanh_pho_bao_loc", 68),
  "D_674": VNDistrict(
      "Huyện Đam Rông", 674, VietnamDivisionType.HUYEN, "huyen_dam_rong", 68),
  "D_675": VNDistrict(
      "Huyện Lạc Dương", 675, VietnamDivisionType.HUYEN, "huyen_lac_duong", 68),
  "D_676": VNDistrict(
      "Huyện Lâm Hà", 676, VietnamDivisionType.HUYEN, "huyen_lam_ha", 68),
  "D_677": VNDistrict(
      "Huyện Đơn Dương", 677, VietnamDivisionType.HUYEN, "huyen_don_duong", 68),
  "D_678": VNDistrict(
      "Huyện Đức Trọng", 678, VietnamDivisionType.HUYEN, "huyen_duc_trong", 68),
  "D_679": VNDistrict(
      "Huyện Di Linh", 679, VietnamDivisionType.HUYEN, "huyen_di_linh", 68),
  "D_680": VNDistrict(
      "Huyện Bảo Lâm", 680, VietnamDivisionType.HUYEN, "huyen_bao_lam", 68),
  "D_681": VNDistrict(
      "Huyện Đạ Huoai", 681, VietnamDivisionType.HUYEN, "huyen_da_huoai", 68),
  "D_682": VNDistrict(
      "Huyện Đạ Tẻh", 682, VietnamDivisionType.HUYEN, "huyen_da_teh", 68),
  "D_683": VNDistrict(
      "Huyện Cát Tiên", 683, VietnamDivisionType.HUYEN, "huyen_cat_tien", 68),
  "D_688": VNDistrict("Thị xã Phước Long", 688, VietnamDivisionType.THI_XA,
      "thi_xa_phuoc_long", 70),
  "D_689": VNDistrict("Thành phố Đồng Xoài", 689, VietnamDivisionType.THANH_PHO,
      "thanh_pho_dong_xoai", 70),
  "D_690": VNDistrict("Thị xã Bình Long", 690, VietnamDivisionType.THI_XA,
      "thi_xa_binh_long", 70),
  "D_691": VNDistrict("Huyện Bù Gia Mập", 691, VietnamDivisionType.HUYEN,
      "huyen_bu_gia_map", 70),
  "D_692": VNDistrict(
      "Huyện Lộc Ninh", 692, VietnamDivisionType.HUYEN, "huyen_loc_ninh", 70),
  "D_693": VNDistrict(
      "Huyện Bù Đốp", 693, VietnamDivisionType.HUYEN, "huyen_bu_dop", 70),
  "D_694": VNDistrict(
      "Huyện Hớn Quản", 694, VietnamDivisionType.HUYEN, "huyen_hon_quan", 70),
  "D_695": VNDistrict(
      "Huyện Đồng Phú", 695, VietnamDivisionType.HUYEN, "huyen_dong_phu", 70),
  "D_696": VNDistrict(
      "Huyện Bù Đăng", 696, VietnamDivisionType.HUYEN, "huyen_bu_dang", 70),
  "D_697": VNDistrict("Huyện Chơn Thành", 697, VietnamDivisionType.HUYEN,
      "huyen_chon_thanh", 70),
  "D_698": VNDistrict(
      "Huyện Phú Riềng", 698, VietnamDivisionType.HUYEN, "huyen_phu_rieng", 70),
  "D_703": VNDistrict("Thành phố Tây Ninh", 703, VietnamDivisionType.THANH_PHO,
      "thanh_pho_tay_ninh", 72),
  "D_705": VNDistrict(
      "Huyện Tân Biên", 705, VietnamDivisionType.HUYEN, "huyen_tan_bien", 72),
  "D_706": VNDistrict(
      "Huyện Tân Châu", 706, VietnamDivisionType.HUYEN, "huyen_tan_chau", 72),
  "D_707": VNDistrict("Huyện Dương Minh Châu", 707, VietnamDivisionType.HUYEN,
      "huyen_duong_minh_chau", 72),
  "D_708": VNDistrict("Huyện Châu Thành", 708, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh", 72),
  "D_709": VNDistrict("Thị xã Hòa Thành", 709, VietnamDivisionType.THI_XA,
      "thi_xa_hoa_thanh", 72),
  "D_710": VNDistrict(
      "Huyện Gò Dầu", 710, VietnamDivisionType.HUYEN, "huyen_go_dau", 72),
  "D_711": VNDistrict(
      "Huyện Bến Cầu", 711, VietnamDivisionType.HUYEN, "huyen_ben_cau", 72),
  "D_712": VNDistrict("Thị xã Trảng Bàng", 712, VietnamDivisionType.THI_XA,
      "thi_xa_trang_bang", 72),
  "D_718": VNDistrict("Thành phố Thủ Dầu Một", 718,
      VietnamDivisionType.THANH_PHO, "thanh_pho_thu_dau_mot", 74),
  "D_719": VNDistrict(
      "Huyện Bàu Bàng", 719, VietnamDivisionType.HUYEN, "huyen_bau_bang", 74),
  "D_720": VNDistrict(
      "Huyện Dầu Tiếng", 720, VietnamDivisionType.HUYEN, "huyen_dau_tieng", 74),
  "D_721": VNDistrict(
      "Thị xã Bến Cát", 721, VietnamDivisionType.THI_XA, "thi_xa_ben_cat", 74),
  "D_722": VNDistrict(
      "Huyện Phú Giáo", 722, VietnamDivisionType.HUYEN, "huyen_phu_giao", 74),
  "D_723": VNDistrict("Thị xã Tân Uyên", 723, VietnamDivisionType.THI_XA,
      "thi_xa_tan_uyen", 74),
  "D_724": VNDistrict("Thành phố Dĩ An", 724, VietnamDivisionType.THANH_PHO,
      "thanh_pho_di_an", 74),
  "D_725": VNDistrict("Thành phố Thuận An", 725, VietnamDivisionType.THANH_PHO,
      "thanh_pho_thuan_an", 74),
  "D_726": VNDistrict("Huyện Bắc Tân Uyên", 726, VietnamDivisionType.HUYEN,
      "huyen_bac_tan_uyen", 74),
  "D_731": VNDistrict("Thành phố Biên Hòa", 731, VietnamDivisionType.THANH_PHO,
      "thanh_pho_bien_hoa", 75),
  "D_732": VNDistrict("Thành phố Long Khánh", 732,
      VietnamDivisionType.THANH_PHO, "thanh_pho_long_khanh", 75),
  "D_734": VNDistrict(
      "Huyện Tân Phú", 734, VietnamDivisionType.HUYEN, "huyen_tan_phu", 75),
  "D_735": VNDistrict(
      "Huyện Vĩnh Cửu", 735, VietnamDivisionType.HUYEN, "huyen_vinh_cuu", 75),
  "D_736": VNDistrict(
      "Huyện Định Quán", 736, VietnamDivisionType.HUYEN, "huyen_dinh_quan", 75),
  "D_737": VNDistrict(
      "Huyện Trảng Bom", 737, VietnamDivisionType.HUYEN, "huyen_trang_bom", 75),
  "D_738": VNDistrict("Huyện Thống Nhất", 738, VietnamDivisionType.HUYEN,
      "huyen_thong_nhat", 75),
  "D_739": VNDistrict(
      "Huyện Cẩm Mỹ", 739, VietnamDivisionType.HUYEN, "huyen_cam_my", 75),
  "D_740": VNDistrict("Huyện Long Thành", 740, VietnamDivisionType.HUYEN,
      "huyen_long_thanh", 75),
  "D_741": VNDistrict(
      "Huyện Xuân Lộc", 741, VietnamDivisionType.HUYEN, "huyen_xuan_loc", 75),
  "D_742": VNDistrict("Huyện Nhơn Trạch", 742, VietnamDivisionType.HUYEN,
      "huyen_nhon_trach", 75),
  "D_747": VNDistrict("Thành phố Vũng Tàu", 747, VietnamDivisionType.THANH_PHO,
      "thanh_pho_vung_tau", 77),
  "D_748": VNDistrict("Thành phố Bà Rịa", 748, VietnamDivisionType.THANH_PHO,
      "thanh_pho_ba_ria", 77),
  "D_750": VNDistrict(
      "Huyện Châu Đức", 750, VietnamDivisionType.HUYEN, "huyen_chau_duc", 77),
  "D_751": VNDistrict(
      "Huyện Xuyên Mộc", 751, VietnamDivisionType.HUYEN, "huyen_xuyen_moc", 77),
  "D_752": VNDistrict(
      "Huyện Long Điền", 752, VietnamDivisionType.HUYEN, "huyen_long_dien", 77),
  "D_753": VNDistrict(
      "Huyện Đất Đỏ", 753, VietnamDivisionType.HUYEN, "huyen_dat_do", 77),
  "D_754": VNDistrict(
      "Thị xã Phú Mỹ", 754, VietnamDivisionType.THI_XA, "thi_xa_phu_my", 77),
  "D_755": VNDistrict(
      "Huyện Côn Đảo", 755, VietnamDivisionType.HUYEN, "huyen_con_dao", 77),
  "D_760": VNDistrict("Quận 1", 760, VietnamDivisionType.QUAN, "quan_1", 79),
  "D_761": VNDistrict("Quận 12", 761, VietnamDivisionType.QUAN, "quan_12", 79),
  "D_764": VNDistrict(
      "Quận Gò Vấp", 764, VietnamDivisionType.QUAN, "quan_go_vap", 79),
  "D_765": VNDistrict(
      "Quận Bình Thạnh", 765, VietnamDivisionType.QUAN, "quan_binh_thanh", 79),
  "D_766": VNDistrict(
      "Quận Tân Bình", 766, VietnamDivisionType.QUAN, "quan_tan_binh", 79),
  "D_767": VNDistrict(
      "Quận Tân Phú", 767, VietnamDivisionType.QUAN, "quan_tan_phu", 79),
  "D_768": VNDistrict(
      "Quận Phú Nhuận", 768, VietnamDivisionType.QUAN, "quan_phu_nhuan", 79),
  "D_769": VNDistrict("Thành phố Thủ Đức", 769, VietnamDivisionType.THANH_PHO,
      "thanh_pho_thu_duc", 79),
  "D_770": VNDistrict("Quận 3", 770, VietnamDivisionType.QUAN, "quan_3", 79),
  "D_771": VNDistrict("Quận 10", 771, VietnamDivisionType.QUAN, "quan_10", 79),
  "D_772": VNDistrict("Quận 11", 772, VietnamDivisionType.QUAN, "quan_11", 79),
  "D_773": VNDistrict("Quận 4", 773, VietnamDivisionType.QUAN, "quan_4", 79),
  "D_774": VNDistrict("Quận 5", 774, VietnamDivisionType.QUAN, "quan_5", 79),
  "D_775": VNDistrict("Quận 6", 775, VietnamDivisionType.QUAN, "quan_6", 79),
  "D_776": VNDistrict("Quận 8", 776, VietnamDivisionType.QUAN, "quan_8", 79),
  "D_777": VNDistrict(
      "Quận Bình Tân", 777, VietnamDivisionType.QUAN, "quan_binh_tan", 79),
  "D_778": VNDistrict("Quận 7", 778, VietnamDivisionType.QUAN, "quan_7", 79),
  "D_783": VNDistrict(
      "Huyện Củ Chi", 783, VietnamDivisionType.HUYEN, "huyen_cu_chi", 79),
  "D_784": VNDistrict(
      "Huyện Hóc Môn", 784, VietnamDivisionType.HUYEN, "huyen_hoc_mon", 79),
  "D_785": VNDistrict("Huyện Bình Chánh", 785, VietnamDivisionType.HUYEN,
      "huyen_binh_chanh", 79),
  "D_786": VNDistrict(
      "Huyện Nhà Bè", 786, VietnamDivisionType.HUYEN, "huyen_nha_be", 79),
  "D_787": VNDistrict(
      "Huyện Cần Giờ", 787, VietnamDivisionType.HUYEN, "huyen_can_gio", 79),
  "D_794": VNDistrict("Thành phố Tân An", 794, VietnamDivisionType.THANH_PHO,
      "thanh_pho_tan_an", 80),
  "D_795": VNDistrict("Thị xã Kiến Tường", 795, VietnamDivisionType.THI_XA,
      "thi_xa_kien_tuong", 80),
  "D_796": VNDistrict(
      "Huyện Tân Hưng", 796, VietnamDivisionType.HUYEN, "huyen_tan_hung", 80),
  "D_797": VNDistrict(
      "Huyện Vĩnh Hưng", 797, VietnamDivisionType.HUYEN, "huyen_vinh_hung", 80),
  "D_798": VNDistrict(
      "Huyện Mộc Hóa", 798, VietnamDivisionType.HUYEN, "huyen_moc_hoa", 80),
  "D_799": VNDistrict(
      "Huyện Tân Thạnh", 799, VietnamDivisionType.HUYEN, "huyen_tan_thanh", 80),
  "D_800": VNDistrict(
      "Huyện Thạnh Hóa", 800, VietnamDivisionType.HUYEN, "huyen_thanh_hoa", 80),
  "D_801": VNDistrict(
      "Huyện Đức Huệ", 801, VietnamDivisionType.HUYEN, "huyen_duc_hue", 80),
  "D_802": VNDistrict(
      "Huyện Đức Hòa", 802, VietnamDivisionType.HUYEN, "huyen_duc_hoa", 80),
  "D_803": VNDistrict(
      "Huyện Bến Lức", 803, VietnamDivisionType.HUYEN, "huyen_ben_luc", 80),
  "D_804": VNDistrict(
      "Huyện Thủ Thừa", 804, VietnamDivisionType.HUYEN, "huyen_thu_thua", 80),
  "D_805": VNDistrict(
      "Huyện Tân Trụ", 805, VietnamDivisionType.HUYEN, "huyen_tan_tru", 80),
  "D_806": VNDistrict(
      "Huyện Cần Đước", 806, VietnamDivisionType.HUYEN, "huyen_can_duoc", 80),
  "D_807": VNDistrict(
      "Huyện Cần Giuộc", 807, VietnamDivisionType.HUYEN, "huyen_can_giuoc", 80),
  "D_808": VNDistrict("Huyện Châu Thành", 808, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh", 80),
  "D_815": VNDistrict("Thành phố Mỹ Tho", 815, VietnamDivisionType.THANH_PHO,
      "thanh_pho_my_tho", 82),
  "D_816": VNDistrict(
      "Thị xã Gò Công", 816, VietnamDivisionType.THI_XA, "thi_xa_go_cong", 82),
  "D_817": VNDistrict(
      "Thị xã Cai Lậy", 817, VietnamDivisionType.THI_XA, "thi_xa_cai_lay", 82),
  "D_818": VNDistrict(
      "Huyện Tân Phước", 818, VietnamDivisionType.HUYEN, "huyen_tan_phuoc", 82),
  "D_819": VNDistrict(
      "Huyện Cái Bè", 819, VietnamDivisionType.HUYEN, "huyen_cai_be", 82),
  "D_820": VNDistrict(
      "Huyện Cai Lậy", 820, VietnamDivisionType.HUYEN, "huyen_cai_lay", 82),
  "D_821": VNDistrict("Huyện Châu Thành", 821, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh", 82),
  "D_822": VNDistrict(
      "Huyện Chợ Gạo", 822, VietnamDivisionType.HUYEN, "huyen_cho_gao", 82),
  "D_823": VNDistrict("Huyện Gò Công Tây", 823, VietnamDivisionType.HUYEN,
      "huyen_go_cong_tay", 82),
  "D_824": VNDistrict("Huyện Gò Công Đông", 824, VietnamDivisionType.HUYEN,
      "huyen_go_cong_dong", 82),
  "D_825": VNDistrict("Huyện Tân Phú Đông", 825, VietnamDivisionType.HUYEN,
      "huyen_tan_phu_dong", 82),
  "D_829": VNDistrict("Thành phố Bến Tre", 829, VietnamDivisionType.THANH_PHO,
      "thanh_pho_ben_tre", 83),
  "D_831": VNDistrict("Huyện Châu Thành", 831, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh", 83),
  "D_832": VNDistrict(
      "Huyện Chợ Lách", 832, VietnamDivisionType.HUYEN, "huyen_cho_lach", 83),
  "D_833": VNDistrict("Huyện Mỏ Cày Nam", 833, VietnamDivisionType.HUYEN,
      "huyen_mo_cay_nam", 83),
  "D_834": VNDistrict("Huyện Giồng Trôm", 834, VietnamDivisionType.HUYEN,
      "huyen_giong_trom", 83),
  "D_835": VNDistrict(
      "Huyện Bình Đại", 835, VietnamDivisionType.HUYEN, "huyen_binh_dai", 83),
  "D_836": VNDistrict(
      "Huyện Ba Tri", 836, VietnamDivisionType.HUYEN, "huyen_ba_tri", 83),
  "D_837": VNDistrict(
      "Huyện Thạnh Phú", 837, VietnamDivisionType.HUYEN, "huyen_thanh_phu", 83),
  "D_838": VNDistrict("Huyện Mỏ Cày Bắc", 838, VietnamDivisionType.HUYEN,
      "huyen_mo_cay_bac", 83),
  "D_842": VNDistrict("Thành phố Trà Vinh", 842, VietnamDivisionType.THANH_PHO,
      "thanh_pho_tra_vinh", 84),
  "D_844": VNDistrict(
      "Huyện Càng Long", 844, VietnamDivisionType.HUYEN, "huyen_cang_long", 84),
  "D_845": VNDistrict(
      "Huyện Cầu Kè", 845, VietnamDivisionType.HUYEN, "huyen_cau_ke", 84),
  "D_846": VNDistrict(
      "Huyện Tiểu Cần", 846, VietnamDivisionType.HUYEN, "huyen_tieu_can", 84),
  "D_847": VNDistrict("Huyện Châu Thành", 847, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh", 84),
  "D_848": VNDistrict(
      "Huyện Cầu Ngang", 848, VietnamDivisionType.HUYEN, "huyen_cau_ngang", 84),
  "D_849": VNDistrict(
      "Huyện Trà Cú", 849, VietnamDivisionType.HUYEN, "huyen_tra_cu", 84),
  "D_850": VNDistrict(
      "Huyện Duyên Hải", 850, VietnamDivisionType.HUYEN, "huyen_duyen_hai", 84),
  "D_851": VNDistrict("Thị xã Duyên Hải", 851, VietnamDivisionType.THI_XA,
      "thi_xa_duyen_hai", 84),
  "D_855": VNDistrict("Thành phố Vĩnh Long", 855, VietnamDivisionType.THANH_PHO,
      "thanh_pho_vinh_long", 86),
  "D_857": VNDistrict(
      "Huyện Long Hồ", 857, VietnamDivisionType.HUYEN, "huyen_long_ho", 86),
  "D_858": VNDistrict(
      "Huyện Mang Thít", 858, VietnamDivisionType.HUYEN, "huyen_mang_thit", 86),
  "D_859": VNDistrict(
      "Huyện Vũng Liêm", 859, VietnamDivisionType.HUYEN, "huyen_vung_liem", 86),
  "D_860": VNDistrict(
      "Huyện Tam Bình", 860, VietnamDivisionType.HUYEN, "huyen_tam_binh", 86),
  "D_861": VNDistrict("Thị xã Bình Minh", 861, VietnamDivisionType.THI_XA,
      "thi_xa_binh_minh", 86),
  "D_862": VNDistrict(
      "Huyện Trà Ôn", 862, VietnamDivisionType.HUYEN, "huyen_tra_on", 86),
  "D_863": VNDistrict(
      "Huyện Bình Tân", 863, VietnamDivisionType.HUYEN, "huyen_binh_tan", 86),
  "D_866": VNDistrict("Thành phố Cao Lãnh", 866, VietnamDivisionType.THANH_PHO,
      "thanh_pho_cao_lanh", 87),
  "D_867": VNDistrict("Thành phố Sa Đéc", 867, VietnamDivisionType.THANH_PHO,
      "thanh_pho_sa_dec", 87),
  "D_868": VNDistrict("Thành phố Hồng Ngự", 868, VietnamDivisionType.THANH_PHO,
      "thanh_pho_hong_ngu", 87),
  "D_869": VNDistrict(
      "Huyện Tân Hồng", 869, VietnamDivisionType.HUYEN, "huyen_tan_hong", 87),
  "D_870": VNDistrict(
      "Huyện Hồng Ngự", 870, VietnamDivisionType.HUYEN, "huyen_hong_ngu", 87),
  "D_871": VNDistrict(
      "Huyện Tam Nông", 871, VietnamDivisionType.HUYEN, "huyen_tam_nong", 87),
  "D_872": VNDistrict(
      "Huyện Tháp Mười", 872, VietnamDivisionType.HUYEN, "huyen_thap_muoi", 87),
  "D_873": VNDistrict(
      "Huyện Cao Lãnh", 873, VietnamDivisionType.HUYEN, "huyen_cao_lanh", 87),
  "D_874": VNDistrict("Huyện Thanh Bình", 874, VietnamDivisionType.HUYEN,
      "huyen_thanh_binh", 87),
  "D_875": VNDistrict(
      "Huyện Lấp Vò", 875, VietnamDivisionType.HUYEN, "huyen_lap_vo", 87),
  "D_876": VNDistrict(
      "Huyện Lai Vung", 876, VietnamDivisionType.HUYEN, "huyen_lai_vung", 87),
  "D_877": VNDistrict("Huyện Châu Thành", 877, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh", 87),
  "D_883": VNDistrict("Thành phố Long Xuyên", 883,
      VietnamDivisionType.THANH_PHO, "thanh_pho_long_xuyen", 89),
  "D_884": VNDistrict("Thành phố Châu Đốc", 884, VietnamDivisionType.THANH_PHO,
      "thanh_pho_chau_doc", 89),
  "D_886": VNDistrict(
      "Huyện An Phú", 886, VietnamDivisionType.HUYEN, "huyen_an_phu", 89),
  "D_887": VNDistrict("Thị xã Tân Châu", 887, VietnamDivisionType.THI_XA,
      "thi_xa_tan_chau", 89),
  "D_888": VNDistrict(
      "Huyện Phú Tân", 888, VietnamDivisionType.HUYEN, "huyen_phu_tan", 89),
  "D_889": VNDistrict(
      "Huyện Châu Phú", 889, VietnamDivisionType.HUYEN, "huyen_chau_phu", 89),
  "D_890": VNDistrict(
      "Huyện Tịnh Biên", 890, VietnamDivisionType.HUYEN, "huyen_tinh_bien", 89),
  "D_891": VNDistrict(
      "Huyện Tri Tôn", 891, VietnamDivisionType.HUYEN, "huyen_tri_ton", 89),
  "D_892": VNDistrict("Huyện Châu Thành", 892, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh", 89),
  "D_893": VNDistrict(
      "Huyện Chợ Mới", 893, VietnamDivisionType.HUYEN, "huyen_cho_moi", 89),
  "D_894": VNDistrict(
      "Huyện Thoại Sơn", 894, VietnamDivisionType.HUYEN, "huyen_thoai_son", 89),
  "D_899": VNDistrict("Thành phố Rạch Giá", 899, VietnamDivisionType.THANH_PHO,
      "thanh_pho_rach_gia", 91),
  "D_900": VNDistrict("Thành phố Hà Tiên", 900, VietnamDivisionType.THANH_PHO,
      "thanh_pho_ha_tien", 91),
  "D_902": VNDistrict("Huyện Kiên Lương", 902, VietnamDivisionType.HUYEN,
      "huyen_kien_luong", 91),
  "D_903": VNDistrict(
      "Huyện Hòn Đất", 903, VietnamDivisionType.HUYEN, "huyen_hon_dat", 91),
  "D_904": VNDistrict(
      "Huyện Tân Hiệp", 904, VietnamDivisionType.HUYEN, "huyen_tan_hiep", 91),
  "D_905": VNDistrict("Huyện Châu Thành", 905, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh", 91),
  "D_906": VNDistrict("Huyện Giồng Riềng", 906, VietnamDivisionType.HUYEN,
      "huyen_giong_rieng", 91),
  "D_907": VNDistrict(
      "Huyện Gò Quao", 907, VietnamDivisionType.HUYEN, "huyen_go_quao", 91),
  "D_908": VNDistrict(
      "Huyện An Biên", 908, VietnamDivisionType.HUYEN, "huyen_an_bien", 91),
  "D_909": VNDistrict(
      "Huyện An Minh", 909, VietnamDivisionType.HUYEN, "huyen_an_minh", 91),
  "D_910": VNDistrict("Huyện Vĩnh Thuận", 910, VietnamDivisionType.HUYEN,
      "huyen_vinh_thuan", 91),
  "D_911": VNDistrict("Thành phố Phú Quốc", 911, VietnamDivisionType.THANH_PHO,
      "thanh_pho_phu_quoc", 91),
  "D_912": VNDistrict(
      "Huyện Kiên Hải", 912, VietnamDivisionType.HUYEN, "huyen_kien_hai", 91),
  "D_913": VNDistrict("Huyện U Minh Thượng", 913, VietnamDivisionType.HUYEN,
      "huyen_u_minh_thuong", 91),
  "D_914": VNDistrict("Huyện Giang Thành", 914, VietnamDivisionType.HUYEN,
      "huyen_giang_thanh", 91),
  "D_916": VNDistrict(
      "Quận Ninh Kiều", 916, VietnamDivisionType.QUAN, "quan_ninh_kieu", 92),
  "D_917":
      VNDistrict("Quận Ô Môn", 917, VietnamDivisionType.QUAN, "quan_o_mon", 92),
  "D_918": VNDistrict(
      "Quận Bình Thuỷ", 918, VietnamDivisionType.QUAN, "quan_binh_thuy", 92),
  "D_919": VNDistrict(
      "Quận Cái Răng", 919, VietnamDivisionType.QUAN, "quan_cai_rang", 92),
  "D_923": VNDistrict(
      "Quận Thốt Nốt", 923, VietnamDivisionType.QUAN, "quan_thot_not", 92),
  "D_924": VNDistrict("Huyện Vĩnh Thạnh", 924, VietnamDivisionType.HUYEN,
      "huyen_vinh_thanh", 92),
  "D_925": VNDistrict(
      "Huyện Cờ Đỏ", 925, VietnamDivisionType.HUYEN, "huyen_co_do", 92),
  "D_926": VNDistrict("Huyện Phong Điền", 926, VietnamDivisionType.HUYEN,
      "huyen_phong_dien", 92),
  "D_927": VNDistrict(
      "Huyện Thới Lai", 927, VietnamDivisionType.HUYEN, "huyen_thoi_lai", 92),
  "D_930": VNDistrict("Thành phố Vị Thanh", 930, VietnamDivisionType.THANH_PHO,
      "thanh_pho_vi_thanh", 93),
  "D_931": VNDistrict("Thành phố Ngã Bảy", 931, VietnamDivisionType.THANH_PHO,
      "thanh_pho_nga_bay", 93),
  "D_932": VNDistrict("Huyện Châu Thành A", 932, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh_a", 93),
  "D_933": VNDistrict("Huyện Châu Thành", 933, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh", 93),
  "D_934": VNDistrict("Huyện Phụng Hiệp", 934, VietnamDivisionType.HUYEN,
      "huyen_phung_hiep", 93),
  "D_935": VNDistrict(
      "Huyện Vị Thuỷ", 935, VietnamDivisionType.HUYEN, "huyen_vi_thuy", 93),
  "D_936": VNDistrict(
      "Huyện Long Mỹ", 936, VietnamDivisionType.HUYEN, "huyen_long_my", 93),
  "D_937": VNDistrict(
      "Thị xã Long Mỹ", 937, VietnamDivisionType.THI_XA, "thi_xa_long_my", 93),
  "D_941": VNDistrict("Thành phố Sóc Trăng", 941, VietnamDivisionType.THANH_PHO,
      "thanh_pho_soc_trang", 94),
  "D_942": VNDistrict("Huyện Châu Thành", 942, VietnamDivisionType.HUYEN,
      "huyen_chau_thanh", 94),
  "D_943": VNDistrict(
      "Huyện Kế Sách", 943, VietnamDivisionType.HUYEN, "huyen_ke_sach", 94),
  "D_944": VNDistrict(
      "Huyện Mỹ Tú", 944, VietnamDivisionType.HUYEN, "huyen_my_tu", 94),
  "D_945": VNDistrict("Huyện Cù Lao Dung", 945, VietnamDivisionType.HUYEN,
      "huyen_cu_lao_dung", 94),
  "D_946": VNDistrict(
      "Huyện Long Phú", 946, VietnamDivisionType.HUYEN, "huyen_long_phu", 94),
  "D_947": VNDistrict(
      "Huyện Mỹ Xuyên", 947, VietnamDivisionType.HUYEN, "huyen_my_xuyen", 94),
  "D_948": VNDistrict(
      "Thị xã Ngã Năm", 948, VietnamDivisionType.THI_XA, "thi_xa_nga_nam", 94),
  "D_949": VNDistrict(
      "Huyện Thạnh Trị", 949, VietnamDivisionType.HUYEN, "huyen_thanh_tri", 94),
  "D_950": VNDistrict("Thị xã Vĩnh Châu", 950, VietnamDivisionType.THI_XA,
      "thi_xa_vinh_chau", 94),
  "D_951": VNDistrict(
      "Huyện Trần Đề", 951, VietnamDivisionType.HUYEN, "huyen_tran_de", 94),
  "D_954": VNDistrict("Thành phố Bạc Liêu", 954, VietnamDivisionType.THANH_PHO,
      "thanh_pho_bac_lieu", 95),
  "D_956": VNDistrict(
      "Huyện Hồng Dân", 956, VietnamDivisionType.HUYEN, "huyen_hong_dan", 95),
  "D_957": VNDistrict("Huyện Phước Long", 957, VietnamDivisionType.HUYEN,
      "huyen_phuoc_long", 95),
  "D_958": VNDistrict(
      "Huyện Vĩnh Lợi", 958, VietnamDivisionType.HUYEN, "huyen_vinh_loi", 95),
  "D_959": VNDistrict(
      "Thị xã Giá Rai", 959, VietnamDivisionType.THI_XA, "thi_xa_gia_rai", 95),
  "D_960": VNDistrict(
      "Huyện Đông Hải", 960, VietnamDivisionType.HUYEN, "huyen_dong_hai", 95),
  "D_961": VNDistrict(
      "Huyện Hoà Bình", 961, VietnamDivisionType.HUYEN, "huyen_hoa_binh", 95),
  "D_964": VNDistrict("Thành phố Cà Mau", 964, VietnamDivisionType.THANH_PHO,
      "thanh_pho_ca_mau", 96),
  "D_966": VNDistrict(
      "Huyện U Minh", 966, VietnamDivisionType.HUYEN, "huyen_u_minh", 96),
  "D_967": VNDistrict(
      "Huyện Thới Bình", 967, VietnamDivisionType.HUYEN, "huyen_thoi_binh", 96),
  "D_968": VNDistrict("Huyện Trần Văn Thời", 968, VietnamDivisionType.HUYEN,
      "huyen_tran_van_thoi", 96),
  "D_969": VNDistrict(
      "Huyện Cái Nước", 969, VietnamDivisionType.HUYEN, "huyen_cai_nuoc", 96),
  "D_970": VNDistrict(
      "Huyện Đầm Dơi", 970, VietnamDivisionType.HUYEN, "huyen_dam_doi", 96),
  "D_971": VNDistrict(
      "Huyện Năm Căn", 971, VietnamDivisionType.HUYEN, "huyen_nam_can", 96),
  "D_972": VNDistrict(
      "Huyện Phú Tân", 972, VietnamDivisionType.HUYEN, "huyen_phu_tan", 96),
  "D_973": VNDistrict(
      "Huyện Ngọc Hiển", 973, VietnamDivisionType.HUYEN, "huyen_ngoc_hien", 96),
};
