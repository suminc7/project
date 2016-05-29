using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class SelectWeponBox : MonoBehaviour {

	public GameObject wepon;
	public GameObject bar;

	private Vector3 currentPos;
	private Vector3 currentUp;

	private bool isActive = false;
	private float fillAmount = 0;
	private ShowHand ShowHandControl;
	private Image barControl;

	void Start () {
		currentPos = wepon.transform.localPosition;
		currentUp = wepon.transform.right;

		ShowHandControl = GameObject.Find("ShowHand").GetComponent<ShowHand>();

		barControl = bar.GetComponent<Image> ();
		barControl.fillAmount = 0;
	}
	
	// Update is called once per frame
	void Update () {
//		Debug.Log (isActive);
		if (ShowHandControl.GetSelected ()) {
			//DeActiveWepon();
			return;
		}

		/*
		fillAmount -= Time.deltaTime;

		if (isActive) {
			fillAmount += Time.deltaTime * 2f;
		}
		fillAmount = Mathf.Clamp01 (fillAmount);
		barControl.fillAmount = fillAmount;

		if (fillAmount == 1f) {
			barControl.fillAmount = 0;
			ShowHandControl.SelectedSword(wepon);
		}
		*/
	}

	public void SelectWepon(){
		ShowHandControl.SelectedSword(wepon);
	}

	public void ActiveVR(){
		SelectWepon ();
	}

	public void ActiveWepon(){

		if (!isActive) {
			LeanTween.moveLocal(wepon, currentPos + currentUp * 0.3f, 1.0f) .setEase( LeanTweenType.easeOutQuad );
			//LeanTween.rotateZ (wepon, 360f, 3f);
			isActive = true;
		}

	}

	public void DeActiveWepon(){
		if (isActive) {
			barControl.fillAmount = 0;
			LeanTween.moveLocal(wepon, currentPos, 1.0f) .setEase( LeanTweenType.easeOutQuad );
			//LeanTween.rotateZ (wepon, 0f, 0.3f);
			isActive = false;
		}

	}
	
}
