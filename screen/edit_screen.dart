import 'package:archieve_idea/data/idea_info.dart';
import 'package:archieve_idea/database/database_helper.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  IdeaInfo? ideaInfo;

  EditScreen({super.key, this.ideaInfo});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _motiveController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  bool isClickPoint1 = false;
  bool isClickPoint2 = false;
  bool isClickPoint3 = true;
  bool isClickPoint4 = false;
  bool isClickPoint5 = false;

  int priorityPoint = 3;

  //database helper
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    // 수정할 경우, 기존의 데이터를 입력 위젯에 자동 기입
    if (widget.ideaInfo != null) {
      _titleController.text = widget.ideaInfo!.title;
      _motiveController.text = widget.ideaInfo!.motive;
      _contentController.text = widget.ideaInfo!.content;
      if (widget.ideaInfo!.feedback.isNotEmpty) {
        _feedbackController.text = widget.ideaInfo!.feedback;
      }
      initClickStatus();
      switch (widget.ideaInfo!.priority) {
        case 1:
          isClickPoint1 = true;
          break;
        case 2:
          isClickPoint2 = true;
          break;
        case 3:
          isClickPoint3 = true;
          break;
        case 4:
          isClickPoint4 = true;
          break;
        case 5:
          isClickPoint5 = true;
          break;
      }
      priorityPoint = widget.ideaInfo!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: Colors.black,
          ),
          onTap: () {
            // back button
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.ideaInfo == null ? '새 아이디어 작성하기' : '아이디어 편집',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('제목'),
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 41,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffd9d9d9),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: '아이디어 제목',
                    hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                  ),
                  style: TextStyle(fontSize: 12, color: Colors.black),
                  controller: _titleController,
                ),
              ),
              SizedBox(height: 16),
              Text('아이디어를 떠올린 계기'),
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 41,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffd9d9d9),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: '아이디어를 떠올린 계기',
                    hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                  ),
                  style: TextStyle(fontSize: 12, color: Colors.black),
                  controller: _motiveController,
                ),
              ),
              SizedBox(height: 16),
              Text('아이디어 내용'),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: TextField(
                  maxLength: 500,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffd9d9d9),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: '떠오르신 아이디어를 자세하게 적어주세요.',
                    hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                  ),
                  style: TextStyle(fontSize: 12, color: Colors.black),
                  controller: _contentController,
                ),
              ),
              SizedBox(height: 16),
              Text('아이디어 중요도 점수'),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                            color: isClickPoint1
                                ? Color(0xffd6d6d6)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          '1',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        //1. 모든 버튼 값 초기화
                        initClickStatus();
                        //2. 선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 1;
                          isClickPoint1 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                            color: isClickPoint2
                                ? Color(0xffd6d6d6)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          '2',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        //2. 선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 2;
                          isClickPoint2 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                            color: isClickPoint3
                                ? Color(0xffd6d6d6)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          '3',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        //2. 선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 3;
                          isClickPoint3 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                            color: isClickPoint4
                                ? Color(0xffd6d6d6)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          '4',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        //2. 선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 4;
                          isClickPoint4 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                            color: isClickPoint5
                                ? Color(0xffd6d6d6)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          '5',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        //2. 선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 5;
                          isClickPoint5 = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('유저 피드백 사항(선택)'),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: TextField(
                  maxLength: 500,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffd9d9d9),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: '떠오르신 아이디어 기반으로\n전달받은 피드백들을 정리해주세요.',
                    hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                  ),
                  style: TextStyle(fontSize: 12, color: Colors.black),
                  controller: _feedbackController,
                ),
              ),
              SizedBox(height: 16),

              /// 아이디어 작성 완료 버튼
              GestureDetector(
                  child: Container(
                    height: 65,
                    alignment: Alignment.center,
                    child: Text('아이디어 작성 완료'),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onTap: () async {
                    // 아이디어 작성 (database insert) 처리
                    String titleValue = _titleController.text.toString();
                    String motiveValue = _motiveController.text.toString();
                    String contentValue = _contentController.text.toString();
                    String feedbackValue = _feedbackController.text.toString();

                    // 유효성 검사 (비어있는 필수 입력 값에 대한 체크)
                    if (titleValue.isEmpty ||
                        motiveValue.isEmpty ||
                        contentValue.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('비어있는 입력 값이 존재합니다'),
                        duration: Duration(seconds: 2),
                      ));
                      return;
                    }

                    // 아이디어 정보 클래스 인스턴스 생성 후 db 삽입
                    if (widget.ideaInfo == null) {
                      var ideaInfo = IdeaInfo(
                        title: titleValue,
                        motive: motiveValue,
                        content: contentValue,
                        priority: priorityPoint,
                        feedback: feedbackValue.isNotEmpty ? feedbackValue : '',
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                      );
                      await setInsertIdeaInfo(ideaInfo);
                      if (mounted) {
                        Navigator.pop(context, 'insert');
                      }
                    }else{
                      var ideaInfoModify = widget.ideaInfo;
                      ideaInfoModify?.title = titleValue;
                      ideaInfoModify?.motive = motiveValue;
                      ideaInfoModify?.content = contentValue;
                      ideaInfoModify?.priority = priorityPoint;
                      ideaInfoModify?.feedback = feedbackValue.isNotEmpty? feedbackValue : '';

                      await setUpdateIdeaInfo(ideaInfoModify!);

                      if (mounted){
                        Navigator.pop(context, 'update');
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future setInsertIdeaInfo(IdeaInfo ideaInfo) async {
    //삽입하는 메서드
    await dbHelper.initDatabase();
    await dbHelper.insertIdeaInfo(ideaInfo);
  }
  Future setUpdateIdeaInfo(IdeaInfo ideaInfo) async {
    //삽입하는 메서드
    await dbHelper.initDatabase();
    await dbHelper.updateIdeaInfo(ideaInfo);
  }

  void initClickStatus() {
    isClickPoint1 = false;
    isClickPoint2 = false;
    isClickPoint3 = false;
    isClickPoint4 = false;
    isClickPoint5 = false;
  }
}
