import 'package:flutter/material.dart';
import 'package:loventine_flutter/widgets/shimmer_loading/shimmer.dart';

class ShimmerFeeLoading extends StatefulWidget {
  const ShimmerFeeLoading({super.key});

  @override
  State<ShimmerFeeLoading> createState() => _ShimmerFeeLoadingState();
}

class _ShimmerFeeLoadingState extends State<ShimmerFeeLoading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Container(
                    width: 10,
                    height: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34.26),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34.26),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Card(
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.38,
                            height: MediaQuery.sizeOf(context).height * 0.31,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Card(
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.38,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.38,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Container(
                        width: 30,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Container(
                        width: 30,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
